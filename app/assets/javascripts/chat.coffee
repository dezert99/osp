$(document).ready ->
  printMessage = (message) ->
    $('#messages').append(message + "<br>")

  chatChannel = {}
  username = {}

  setupChannel = ->
    chatChannel.on 'messageAdded', (message) ->
      printMessage(message.author + ": " + message.body)

  $input = $('#chat-input')
  $input.on 'keydown', (e) ->
    if e.keyCode == 13
      chatChannel.sendMessage($input.val())
      $input.val('')

  $.post "/tokens", (data) ->
    username = data.username
    accessManager = new Twilio.AccessManager(data.token)
    messagingClient = new Twilio.IPMessaging.Client(accessManager)

    messagingClient.getChannelByUniqueName('chat').then (channel) ->
      if (channel)
        chatChannel = channel
        setupChannel()
      else
        messagingClient.createChannel(
          uniqueName: 'chat'
          friendlyName: 'Chat Channel'
        )
        .then (channel) ->
          chatChannel = channel
          setupChannel()
