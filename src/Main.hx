package ;


import haxe.io.Path;
import sys.io.File;
import sys.io.Process;

import cs.system.threading.Timer;
import cs.system.Console;
import cs.system.threading.Thread;

using StringTools;

/**
 * ...
 * @author lordkryss
 */

class Main 
{
	static private var hxmlFolder:String;
	static private var hxmlPath:String;
	static private var fileName:String;
	static private var final:String;
	
	static function main() 
	{
		if (Sys.args().length < 1)
		{
			trace("Use: autocompile build.hxml");
			Sys.exit(0);
		}
		
		hxmlPath = Sys.args()[0];
		hxmlFolder = Path.directory(hxmlPath);
		fileName = new Path(hxmlPath).file+"."+new Path(hxmlPath).ext;
		var hxml = File.getContent(hxmlPath);
		var sourceFolder = parseHxml(hxml);
		
		final = Path.join([hxmlFolder, sourceFolder]).rtrim();

		if (final.charAt(final.length - 1) == ".")
		{
			final = final.substr(0, final.length - 2);
		}
		trace(final);
		
		var notifier = new ChangeNotifier([final]);
		notifier.onError = onError;
		notifier.onSuccess = onSuccess;
		notifier.onFileChange = onFileChange;
		
		if(hxmlFolder!="")
			Sys.setCwd(hxmlFolder);
		//compile();
		
		onSuccess();
		Console.WriteLine("Press \'q\' to stop.");
		while (Console.Read() != 0)
		{}
		
	}
	
	static private function compile() 
	{
		try {
			var proc = new Process("haxe",[fileName]);
			trace("Output: \n"+ proc.stdout.readAll().toString());
			trace("Errors: \n"+proc.stderr.readAll().toString());
			proc.close();
		
		}catch (e:Dynamic)
		{
			trace("Couldn't compile: \n"+e);
		}		
	}
	
	static private function parseHxml(file) 
	{
		var ereg:EReg = new EReg("-cp ([^- \n]*)","r");
		if (!ereg.match(file))
		{
			trace("invalid hxml file");
			Sys.exit(0);
		}
		return ereg.matched(1);
	}


	
	static private function onFileChange(path:String, ?type:String) 
	{
		trace(path + " has been changed" + (type != null ? type : "-"));
		compile();
	}
	

	
	static private function onError(err) 
	{
		trace("error: " + err); 
	}
	
	static private function onSuccess():Void 
	{
		trace("Watching the folder " + final);
	}
	
}