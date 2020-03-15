// A simple REPL implementation.
// Currently only used for python,
//
// coc-python shifts with a python REPL,
// but it seems unusable now(2020-03-09, wait for newline, same problem below).
// TODO: figure out coc-python's REPL
//
// TODO: https://github.com/sillybun/vim-repl seems nice
//       but having no support for neovim.
//       a ref issue: https://github.com/sillybun/vim-repl/issues/3#issuecomment-517280025
//
// save the file to ~/.vim/coc-extensions
// usage: xmap <silent> <TAB> <Plug>(coc-repl-sendtext)
const { commands, workspace } = require('coc.nvim')

function process_newline(python_code) {
    // two continouse newline will break one big unit input into pieces,
    // e.g., class definition with methods separated by multiple newline.
    // remove these continouse newlines to just keep one.
    //
    // FIXME: continouse newline in string literals will be replaced!
    python_code = python_code.trim().replace(/\n\s*\n/g, '\n')

    const py_block_keywords = [
        'class',
        'def',
        'for',
        'if',
        'while',
    ]

    // FIXME: sometimes ipython will still wait for newline
    // e.g.
    //          x = 3
    //          if x > 3:
    //              print('big')
    //          else:
    //              print('small')
    for (let i = 0; i < py_block_keywords.length; ++i) {
        if (python_code.startsWith(py_block_keywords[i])) {
            // to handle these syntax block correctly by ipython,
            // we need two newline to be the end of the syntax block,
            // and three newline here will make sure ipython
            // recieve exactly two.
            // See: https://github.com/neoclide/coc.nvim/blob/d5e12d81b2e3bd9216098c2d9664a4e66fa0ebb4/autoload/coc/terminal.vim#L64
            return python_code + '\n\n\n'
        }
    }
    return python_code
}

exports.activate = context => {
    let { nvim } = workspace
    let terminal
    context.subscriptions.push(
        commands.registerCommand('repl.openTerminal', async () => {
            let filetype = await nvim.eval('&filetype')
            let prog = ''
            if (filetype == 'javascript') {
                prog = 'node'
            } else if (filetype == 'typescript') {
                prog = 'ts-node'
            } else if (filetype == 'python') {
                prog = 'ipython --no-autoindent --pprint --pdb'
            }
            terminal = await workspace.createTerminal({
                cmd: 'zsh',
                args: '',
            })
            if (prog) {
                // get current window id
                let winid = await nvim.call('win_getid')

                terminal.sendText(prog, true)

                // focus go back to the editing window
                await nvim.call('win_gotoid', winid, true)
            }
        })
    )
    context.subscriptions.push(
        commands.registerCommand('repl.showTerminal', async () => {
            if (terminal) {
                terminal.show()
            }
        })
    )
    context.subscriptions.push(
        commands.registerCommand('repl.disposeTerminal', async () => {
            if (terminal) {
                terminal.dispose()
            }
        })
    )
    context.subscriptions.push(
        workspace.registerKeymap(
            ['x'],
            'repl-sendtext',
            async () => {
                await nvim.call('eval', 'feedkeys("\\<esc>", "in")')
                let doc = workspace.getDocument(workspace.bufnr)
                if (!doc) return
                let visualmode = await nvim.call('visualmode')
                let range = await workspace.getSelectedRange(visualmode, doc)
                if (!range) return
                let text = doc.textDocument.getText(range)

                // get current window id
                let winid = await nvim.call('win_getid')

                if (text && terminal) {
                    terminal.sendText(process_newline(text), true)

                    // focus go back to the editing window
                    await nvim.call('win_gotoid', winid, true)
                }

            },
            { sync: false, silent: true }
        )
    )
}
