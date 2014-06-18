package ;

import js.Browser;
import js.html.Document;
import js.html.EventListener;
import js.Lib;


/**
 * ...
 * @author lordkryss
 */

class Main 
{
	
	static function main() 
	{
		Browser.document.getElementById("foo").addEventListener("click", clickHandler );
	
	}
	
	static function clickHandler(_) {
		Browser.document.getElementById("bar").innerHTML = "foo";
	}
	
}