package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.kam.*;
	import com.parts.*;

	public class ToolKit extends MovieClip {

		public var toolObj:toolKitMC;

		public function ToolKit() {
			toolObj = new toolKitMC();
			addChild(toolObj);

			init();
		}

		function init() {
			toolObj.x=645;
			toolObj.y=50;
			toolObj.buttonMode=true;

			var _toolkitDrager:MCDragger = new MCDragger();
			_toolkitDrager.initDragger(toolObj);
			toolObj.visible=true;


			toolObj.closeToolkitBt.addEventListener(MouseEvent.CLICK, closeToolkitBTHandler);
			toolObj.duplicateBT.addEventListener(MouseEvent.CLICK, duplicateBTHandler);
			toolObj.removeBT.addEventListener(MouseEvent.CLICK, removeBTHandler);
			toolObj.refreshBT.addEventListener(MouseEvent.CLICK, refreshBTHandler);
			toolObj.resetBT.addEventListener(MouseEvent.CLICK, resetBTHandler);

		}


		/*
		******************************************************************************************************
		Actions
		*/
		public function closeToolkitBTHandler(e:MouseEvent) {
			MovieClip(parent).destroyToolKit();
		}


		public function duplicateBTHandler(e:MouseEvent) {
			duplicateWorker();
		}
		public function removeBTHandler(e:MouseEvent) {
			removeWorker();
		}
		public function refreshBTHandler(e:MouseEvent) {
			with(MovieClip(parent)){
				viewHandleCls.reBuildParts();
				viewHandleCls.reBuildEffectedParts();
				viewHandleCls.reBuildPartsDetails();
				viewHandleCls.disableUploadPartButtons();
				viewHandleCls.enablePartUploadButton();
			}
		}
		public function resetBTHandler(e:MouseEvent) {
			//
		}


		/*
		******************************************************************************************************
		Worker functions
		*/
		function duplicateWorker() {
			MovieClip(parent).viewHandleCls.effectCls
			
			if (MovieClip(parent).viewHandleCls.effectCls.partObj) {
				switch (Main.VIEW_CONTROL_VAR) {
					case 'FVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.frontActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.startFrontClips(MovieClip(parent).viewHandleCls.effectCls.partObj.frontImgSrc);
							}
						}
						duplicateHelper();
						break;
					case 'RVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.rearActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.startRearClips(MovieClip(parent).viewHandleCls.effectCls.partObj.rearImgSrc);
							}
						}
						duplicateHelper();
						break;
					case 'IVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.interiorActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.startInteriorClips(MovieClip(parent).viewHandleCls.effectCls.partObj.interiorImgSrc);
							}
						}
						duplicateHelper();
						break;
					case 'OVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.otherActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.startOtherClips(MovieClip(parent).viewHandleCls.effectCls.partObj.otherImgSrc);
							}
						}
						duplicateHelper();
						break;
				}
			}
		}

		function duplicateHelper() {
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallFVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.startFVIEWClips(MovieClip(parent).viewHandleCls.effectCls.partObj.FVIEWImgSrc);
			}
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallRVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.startRVIEWClips(MovieClip(parent).viewHandleCls.effectCls.partObj.RVIEWImgSrc);
			}
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallIVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.startIVIEWClips(MovieClip(parent).viewHandleCls.effectCls.partObj.IVIEWImgSrc);
			}
		}



		function removeWorker() {
			if (MovieClip(parent).viewHandleCls.effectCls.partObj) {
				switch (Main.VIEW_CONTROL_VAR) {
					case 'FVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.frontActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.removeFront();
							}
						}
						removeHelper();
						break;
					case 'RVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.rearActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.removeRear();
							}
						}
						removeHelper();
						break;
					case 'IVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.interiorActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.removeInterior();
							}
						}
						removeHelper();
						break;
					case 'OVIEW' :
						if (MovieClip(parent).viewHandleCls.effectCls.partObj.otherActive) {
							if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is CanvesViewMC) {
								MovieClip(parent).viewHandleCls.effectCls.partObj.removeOther();
							}
						}
						removeHelper();
						break;
				}
			}
		}

		function removeHelper() {
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallFVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.removeFVIEW();
			}
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallRVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.removeRVIEW();
			}
			if (MovieClip(parent).viewHandleCls.effectCls.partObj.currTool.target is SmallIVIEWMC) {
				MovieClip(parent).viewHandleCls.effectCls.partObj.removeIVIEW();
			}
			
			//reset
			if(checkFrontView() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetFront();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.frontActive){
					MovieClip(parent).viewHandleCls.createFrontViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetFrontPart();
			}
			
			if(checkRearView() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetRear();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.rearActive){
					MovieClip(parent).viewHandleCls.createRearViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetRearPart();
			}
			if(checkInteriorView() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetInterior();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.interiorActive){
					MovieClip(parent).viewHandleCls.createInteriorViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetInteriorPart();
			}
			if(checkOtherView() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetOther();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.otherActive){
					MovieClip(parent).viewHandleCls.createOtherViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetOtherPart();
			}
			
			
			if(checkFVIEW() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetFVIEW();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.FVIEWActive){
					MovieClip(parent).viewHandleCls.createFViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetFVIEWPart();
			}
			if(checkRVIEW() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetRVIEW();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.RVIEWActive){
					MovieClip(parent).viewHandleCls.createRViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetRVIEWPart();
			}
			if(checkIVIEW() == 0 ){
				MovieClip(parent).viewHandleCls.effectCls.partObj.resetIVIEW();
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.IVIEWActive){
					MovieClip(parent).viewHandleCls.createIViewButton();
				}
				MovieClip(parent).viewHandleCls.effectCls.resetIVIEWPart();
			}
			
			
		}//$removeHelper
		
		
		
		/*
			******************************************************************************************************************
			Remove
		*/
		function checkFrontView():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.frontMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.frontMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		function checkRearView():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.rearMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.rearMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		function checkInteriorView():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.interiorMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.interiorMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		function checkOtherView():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.otherMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.otherMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		
		
		
		function checkFVIEW():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.FVIEWMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.FVIEWMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		function checkRVIEW():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.RVIEWMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.RVIEWMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		function checkIVIEW():Number{
			var pointer:Number = 0;
			for(var i:Number = 0; i< MovieClip(parent).viewHandleCls.effectCls.partObj.IVIEWMCArr.length; i++){
				if(MovieClip(parent).viewHandleCls.effectCls.partObj.IVIEWMCArr[i] != undefined){
					pointer++;
				}
			}
			return pointer;
		}
		

	}//$class
}//$package