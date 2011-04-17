// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//onSubmit
function check()
{
  if($("#name").val() == '' || $("#name").val() == "Describe your feelings on this picture")
	  return false;
  else
	  return true;
  end
}

//Resize Image OnLoad, use jquery-resize plugin
function ResizePhoto() {
  $("#enjoy-photo").resize({ maxWidth: 800});
}