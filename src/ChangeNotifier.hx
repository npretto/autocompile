package ;

import cs.system.io.FileSystemWatcher;
import cs.system.io.NotifyFilters;
import cs.system.io.FileSystemEventHandler;
import cs.system.io.RenamedEventHandler;
import cs.system.io.RenamedEventArgs;
import cs.system.io.FileSystemEventArgs;

/**
 * ...
 * @author lordkryss
 */
class ChangeNotifier
{
	var watcher:FileSystemWatcher;
	public var onFileChange:String->String->Void;
	public var onSuccess:Void->Void;
	public var onError:String->Void;
	
	public function new(paths:Array<String>) 
	{
		watcher = new FileSystemWatcher();
		watcher.Path = paths[0];
		watcher.NotifyFilter =  untyped __cs__("System.IO.NotifyFilters.LastWrite	| System.IO.NotifyFilters.FileName | System.IO.NotifyFilters.DirectoryName");
		watcher.add_Changed(fileChange.bind("add_Changed"));
		watcher.add_Created(fileChange.bind("add_Created"));
		watcher.add_Deleted(fileChange.bind("add_Deleted"));
		watcher.add_Renamed(fileChange.bind("add_Renamed"));
		watcher.Filter = "*.hx";
		watcher.IncludeSubdirectories = true;
		watcher.EnableRaisingEvents = true;
	}
	
	
	private function error(err:String)
	{
		if (onError != null)
			onError(err);
	}
	private function success()
	{
		if (onSuccess != null)
			onSuccess();
	}
	private function fileChange(type:String,source:Dynamic,args:FileSystemEventArgs)
	{
		if (onFileChange != null)
			onFileChange(args.FullPath,  type );
	}
}