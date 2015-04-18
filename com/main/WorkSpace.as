package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;


	public class WorkSpace extends MovieClip {

		
		public var tabCls:Tabs;
		public var outlineObj:outlineContainers;
		
		
		public var assetCls:Assets;
		
		
		//  Constructors
		public function WorkSpace() {
			setOutlines();
			
			tabCls = new Tabs();
			addChild(tabCls);
			
			
			assetCls = new Assets();
			addChild(assetCls);
			addEventListener(Event.ADDED, assetObjectAdded);
			
		}
		
		public function assetObjectAdded(e:Event):void {
			//assetCls.loadVehicle( MovieClip(parent).dashCls.$vehicle_id ,MovieClip(parent).dashCls.$trim_id , MovieClip(parent).dashCls.$exterior_color_id  , MovieClip(parent).dashCls.$interior_color_id);
			assetCls.loadCoordinates( MovieClip(parent).dashCls.$vehicle_id ,MovieClip(parent).dashCls.$trim_id , MovieClip(parent).dashCls.$exterior_color_id  , MovieClip(parent).dashCls.$interior_color_id);
			MovieClip(parent).buildList();
			MovieClip(parent).destroyDashboard();
			removeEventListener(Event.ADDED, assetObjectAdded);
		}
		
		
		public function removeTabes(){
			if(tabCls){
				removeChild(tabCls);
				tabCls = null;
			}
		}
		
		//Other's 
		public function setOutlines():void{
			outlineObj = new outlineContainers();
			addChild(outlineObj);
			outlineObj.x = 600;
			outlineObj.y = 422;
		}
		
		public function removeOutLine(){
			if(outlineObj){
				removeChild(outlineObj);
				outlineObj = null;
			}
		}
		
		



	}//$class
}//$package