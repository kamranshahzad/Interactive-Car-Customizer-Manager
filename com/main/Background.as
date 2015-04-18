package com.main{
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	
	public class Background extends MovieClip{
		
		public var bgObj:backGround;
		
		public function Background(){
			bgObj = new backGround();
			addChild(bgObj);
			bgObj.x = 600;
			bgObj.y = 422;
		}
		
		
		
		
	} //$class
} //$package