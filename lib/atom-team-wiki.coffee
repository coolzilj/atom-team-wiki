{CompositeDisposable} = require 'atom'

AtomTeamWikiView = null
AtomTeamWikiUri = 'atom://atom-team-wiki/atom-team-wiki'

createAtomTeamWikiView = (state) ->
  AtomTeamWikiView ?= require './atom-team-wiki-view'
  new AtomTeamWikiView(state)

atom.deserializers.add
  name: 'AtomTeamWikiView'
  deserialize: (state) -> createAtomTeamWikiView(state)

module.exports = AtomTeamWiki =
  config:
    showOnStartup:
      type: 'boolean'
      default: true

  activate: ->
    @subscriptions = new CompositeDisposable

    process.nextTick =>
      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createAtomTeamWikiView(uri: AtomTeamWikiUri) if filePath is AtomTeamWikiUri
      @subscriptions.add atom.commands.add 'atom-workspace', 'atom-team-wiki:show', => @show()
      if atom.config.get('atom-team-wiki.showOnStartup')
        @show()
        atom.config.set('atom-team-wiki.showOnStartup', false)

  show: ->
    atom.workspace.open(AtomTeamWikiUri)

  deactivate: ->
    @subscriptions.dispose()
