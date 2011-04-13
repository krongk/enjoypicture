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