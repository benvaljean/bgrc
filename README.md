# bgrc
Improvements or suggestions to your shell experience.

bgrc is a set of improvements and suggestions from the simple defaults in your shell experience. Currently bash, vim and screen are improved. Feel free to investigate and cherry-pick or trying using `deploy_bgrc` to deploy the whole environment.

## Quickstart

To deploy the whole environment:

	git clone --recursive git@github.com:benvaljean/bgrc.git
	cd bgrc/bin
	./deploy_bgrc --local

Caution: vim and screen config could be overwritten (bashrc remains intact)
## bgbashrc

`.bgrc`
Improvements to bash and some commonly used programmes

*Features include*

- Improvements to bash history - longer history, common and dupes ignored and timestamp added
- Colours used in grep/ls when supported
- ssh auto-complete based on ssh known hosts
- Useful prompt
- Page commands on long-output with `page command`
- grep through history with `hg pattern`
- View only column x when you pipe to `prow x`

## bgvimrc

`.vimrc`
Improvements to vimrc

*Features include*

- Use `;` instead of `:` for commands - no need to press shift
- Use `qq` instead of `q!` to exit without saving - now exit a file without saving by typing `;qq` instead of `:q!` by default.
- Syntax highlighting with solarized colours
- NERDTree plugin allow you to browse and view files in a tree view

## bgscreenrc

`.screenrc`
Improvements to screenrc

- Use Ctrl-L instead of Ctrl-D as the command character to free up Ctrl-D for bash.
- Longer screen scrollback

## deploy_bgrc

`deploy_bgrc`
Deploy all the above to a remote server or locally from a cloned repo. If deployed to an existing non-vanilla account it should be used with cauion as currently it will overwrite your vim and screen config. bashrc config is remained intact.
