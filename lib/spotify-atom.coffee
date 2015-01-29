SpotifyAtomView = require './spotify-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = SpotifyAtom =
  spotifyAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @spotifyAtomView = new SpotifyAtomView(state.spotifyAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @spotifyAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'spotify-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @spotifyAtomView.destroy()

  serialize: ->
    spotifyAtomViewState: @spotifyAtomView.serialize()

  toggle: ->
    console.log 'SpotifyAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
