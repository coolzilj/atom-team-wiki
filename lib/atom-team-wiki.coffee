AtomTeamWikiView = require './atom-team-wiki-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomTeamWiki =
  atomTeamWikiView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomTeamWikiView = new AtomTeamWikiView(state.atomTeamWikiViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomTeamWikiView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-team-wiki:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomTeamWikiView.destroy()

  serialize: ->
    atomTeamWikiViewState: @atomTeamWikiView.serialize()

  toggle: ->
    console.log 'AtomTeamWiki was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
