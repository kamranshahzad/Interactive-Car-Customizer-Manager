package com.main{
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	import gs.TweenLite;
	
	import com.preloader.Preloader;
	
	public class PreLoadAssets extends MovieClip{
		
		public var preloader:Preloader;
		public var blackWall:MovieClip;
		
		
		public function PreLoadAssets(){}
		
		/* System Preloaders */
		public function pleaseWait($msg:String , xPos:Number = 550 , yPos:Number = 390 ) {
			preloader=new Preloader($msg);
			addChild(preloader);
			preloader.x=xPos;
			preloader.y=yPos;
		}

		public function endWait() {
			if (preloader) {
				removeChild(preloader);
				preloader=null;
			}
		}
		
		
	} //$class
} //$package