SwaptabAtomView = require './swaptab-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = SwaptabAtom =
  swaptabAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @swaptabAtomView = new SwaptabAtomView(state.swaptabAtomViewState)
    console.log "here1"
    @modalPanel = atom.workspace.addModalPanel(item: @swaptabAtomView.getElement(), visible: false)
    console.log "here2"
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    console.log "here3"
    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'swaptab-atom:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'swaptab-atom:move-tab-right': => @moveRight()
    @subscriptions.add atom.commands.add 'atom-workspace', 'swaptab-atom:move-tab-left': => @moveLeft()

  moveRight: ->
    pane = atom.workspace.getActivePane()
    pane.moveItemRight()

  moveLeft: ->
    pane = atom.workspace.getActivePane()
    pane.moveItemLeft()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @swaptabAtomView.destroy()

  serialize: ->
    swaptabAtomViewState: @swaptabAtomView.serialize()

  toggle: ->
    console.log 'SwaptabAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
