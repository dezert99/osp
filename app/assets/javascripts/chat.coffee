$(document).ready ->
  printMessage = (message) ->
    $('#messages').append(message + "<br>")

  chatChannel = {}
  username = {}

  setupChannel = ->
    chatChannel.join().then ->
      chatChannel.on 'messageAdded', (message) ->
        printMessage "#{message.author}: #{message.body}"


      chatChannel.getMessages().then (messages) ->
        totalMessages = messages.length
        for message in messages
          printMessage(message.author + ": " + message.body);

        $(document).scrollTop $(document).height()

  $input = $('#chat-input')
  $input.on 'keydown', (e) ->
    if e.keyCode == 13
      chatChannel.sendMessage($input.val())
      $input.val('')

  $.post "/tokens", (data) ->
    username = data.username
    accessManager = new Twilio.AccessManager(data.token)
    messagingClient = new Twilio.IPMessaging.Client(accessManager)

    messagingClient.getChannelByUniqueName('off-chat').then (channel) ->
      if (channel)
        chatChannel = channel
        setupChannel()
      else
        messagingClient.createChannel(
          uniqueName: 'off-chat'
          friendlyName: 'OSP1'
        )
        .then (channel) ->
          chatChannel = channel
          setupChannel()
