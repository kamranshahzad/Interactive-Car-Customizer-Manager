package com.partslist{
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	
	public class PartMC extends MovieClip{
		
		public var normalMc:MovieClip;
		public var selectMC:MovieClip;
		
		
		// data of the class
		public var CAT_TYPE:String;
		public var CAT_ID:Number;
		public var PART_ID:Number;
		
		public var imgSrc:String;
		public var partlbl:String;
		public var partPrice:Number;
		public var montlyPartPrice:Number;
		public var partDescription:String;
		public var partManufacture:String;
		public var partSKU:String;
		public var partStatus:Number;
		
		
		public var FROM:String = '';
		
		public function PartMC(){  // Constructor			
			
		} 
		
		public function getTest(){
			trace(CAT_TYPE);
		}
		
		
		
		
	} //$class
} //$package