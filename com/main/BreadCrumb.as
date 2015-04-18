package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;



	public class BreadCrumb extends MovieClip {

		public var breadObj:breadcrumb;

		public function BreadCrumb() {
			breadObj=new breadcrumb();
			addChild(breadObj);
			
			init();
		}


		public function init() {
			breadObj.x=600;
			breadObj.y=65;
			
			breadObj.showToolkitBt.mouseEnabled = false;
			breadObj.showToolkitBt.addEventListener(MouseEvent.CLICK, showToolkitClick);
			breadObj.homeBtn.addEventListener(MouseEvent.CLICK, homeClick);
			breadObj.logOutBtn.addEventListener(MouseEvent.CLICK, logOutClick);
		}
		
		public function homeClick(e:MouseEvent){
			MovieClip(parent).destroyDashboard();
			MovieClip(parent).buildDashboard();
			MovieClip(parent).destroyWorkspace();
			MovieClip(parent).destroyList();
			resetBreadCrumb();
			//MovieClip(parent).buildWorkspace();
		}
		
		public function enableToolkitButton():void{
			breadObj.showToolkitBt.mouseEnabled = true;
		}
		
		public function disableToolkitButton():void{
			breadObj.showToolkitBt.mouseEnabled = false;
		}
		

		public function showToolkitClick(e:MouseEvent) {
			//toolKit.visible=true;
			//bread.showToolkitBt.visible=false;
			MovieClip(parent).workCls.assetCls.buildToolkit();
		}

		
		function logOutClick(e:MouseEvent) {
			trace("#1");
			MovieClip(parent).buildLoginWindow();
			trace("#2");
			MovieClip(parent).destroyBackground();
			trace("#3");
			MovieClip(parent).destroyWorkspace();
			trace("#4");
			MovieClip(parent).destroyDashboard();
			trace("#5");
			MovieClip(parent).destroyList();
			trace("#6");
			MovieClip(parent).destroyBreadCrumb();
			trace("#8");
		}
		
		
		function resetBreadCrumb():void{
			breadObj.makeTxt.text = "None";
			breadObj.yearTxt.text = "None";
			breadObj.modelTxt.text = "None";
			breadObj.trimTxt.text = "None";
			breadObj.exteriorTxt.text = "None";
			breadObj.interiorTxt.text = "None";
		}


	}//$class
}//$package