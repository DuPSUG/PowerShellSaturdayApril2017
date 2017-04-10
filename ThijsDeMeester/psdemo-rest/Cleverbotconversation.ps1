<#
  Cleverbot docs
  start-process 'https://www.cleverbot.com/api/howto/'
#>

#region key
$cleverbotkey = get-content  C:\Development\psdemo-rest\Cleverbotkey.txt
#endregion

#region start conversation
$URI = "https://www.cleverbot.com/getreply?key=$cleverbotkey"
$conversationWebRequest = invoke-webrequest -Uri $URI -Method Get
$conversationWebREquest
#endregion

#region parse content

$conversationWebREquest.content | convertfrom-json

#endregion

#region request and parse
$URI = "https://www.cleverbot.com/getreply?key=$cleverbotkey"
$conversationRestMethod = invoke-RestMethod -Uri $URI -Method Get
$conversationRestMethod 

#endregion

#region start conversation
$conversationRestMethod.output

$conversationInput = 'Hi.'

#example http://www.cleverbot.com/getreply?key=YOURAPIKEY&input=Hello&callback=ProcessReply
$conversationID = $conversationRestMethod.conversation_id

$URI  = "https://www.cleverbot.com/getreply?"
$URI += "key=$cleverbotkey&"
$URI += "input=$conversationInput&"
$URI

$conversationRestMethod = invoke-RestMethod -Uri $URI -Method Get
$conversationRestMethod.output

#endregion

#region conversation function

function Send-ConversationInput {
  param(
    [parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('conversation_id')]
    [string]$conversationID,

    [string]$conversationInput,

    [string]$cleverbotkey = $global:cleverbotkey
  )

  $URI  = "https://www.cleverbot.com/getreply?"
  $URI += "key=$cleverbotkey&"
  $URI += "input=$conversationInput&"

  if($conversationID){
    $URI += "cs=$conversationID"
  }
  $conversationRestMethod = invoke-RestMethod -Uri $URI -Method Get
  write-information ('You:        {0}' -f $conversationInput) -InformationAction Continue
  write-information ('    Reply:  {0}' -f $conversationRestMethod.output) -InformationAction Continue

  write-verbose ('You as Concieved by cleverbot:     "{0}"' -f $conversationRestMethod.input) -InformationAction Continue
  $conversationRestMethod
}

$SendConversationInputSplat = @{
  conversationInput = 'how old are you?'
}
$conversationRestMethod = $conversationRestMethod |  Send-ConversationInput @SendConversationInputSplat
#endregion



invoke-RestMethod -Uri $URI -Method Get -Credential (get-credential)


