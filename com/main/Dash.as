package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSON;

	import flash.net.NetConnection;
	import flash.net.Responder;


	public class Dash extends MovieClip {

		public var dashObj:dashBoard;
		public var loaderCls:PreLoadAssets;
		public var wallCls:BlackWall;

		public var settingLr:Loader;
		public var userLr:Loader;
		public var bgLr:Loader;
		public var mkLr:Loader;
		public var yearLr:Loader;
		public var manufacturerLr:Loader;
		public var partTypeFrmLr:Loader;
		public var partCatFrmLr:Loader;
		public var wheelSizeLr:Loader;
		public var wheelCatLr:Loader;
		public var coordinatesLr:Loader;

		public var makeGrdLr:Loader;
		public var modelGrdLr:Loader;
		public var trimGrdLr:Loader;
		public var interiorGrdLr:Loader;
		public var exteriorGrdLr:Loader;
		public var viewGrdLr:Loader;
		public var bgGrdLr:Loader;

		public var settingFrmMC:MovieClip;
		public var userFrmMC:MovieClip;
		public var bgFrmMC:MovieClip;
		public var mkFrmMC:MovieClip;
		public var yearFrmMC:MovieClip;
		public var manufacturerFrmMC:MovieClip;
		public var partTypeFrmMC:MovieClip;
		public var partCatFrmMC:MovieClip;
		public var wheelSizeFrmMC:MovieClip;
		public var wheelCatFrmMC:MovieClip;

		public var makeGrdMC:MovieClip;
		public var modelGrdMC:MovieClip;
		public var trimGrdMC:MovieClip;
		public var interiorGrdMC:MovieClip;
		public var exteriorGrdMC:MovieClip;
		public var viewGrdMC:MovieClip;
		public var bgGrdMC:MovieClip;
		public var coordFrmMC:MovieClip;

		public var $make_id:Number=0;
		public var $make_name:String='';
		public var $year_id:Number=0;
		public var $year_title:String='';
		public var $model_id:Number=0;
		public var $model_title:String='';
		public var $trim_id:Number=0;
		public var $trim_title:String='';
		public var $exterior_color_id:Number=0;
		public var $exterior_color_title:String='';
		public var $interior_color_id:Number=0;
		public var $interior_color_title:String='';
		public var $color_id:Number=0;
		public var $background_id:Number=0;
		public var $vehicle_id:Number=0;


		/*
		*********************************************
		Constructor
		*/
		public function Dash() {
			dashObj = new dashBoard();
			addChild(dashObj);
			dashObj.x=600;//600
			dashObj.y=420;

			init();

			wallCls   = new BlackWall();
			addChild(wallCls);

			loaderCls = new PreLoadAssets();
			addChild(loaderCls);

			setDashConfiguration();
		}

		public function init():void {
			dashObj.adNewPartBtn.addEventListener(MouseEvent.CLICK , adNewPartBtnClick);
			dashObj.manufacturer_btn.addEventListener(MouseEvent.CLICK , manufacturerClick);
			dashObj.accessory_types_btn.addEventListener(MouseEvent.CLICK , accessoryTypeClick);
			dashObj.accessory_category_btn.addEventListener(MouseEvent.CLICK , accessoryCatClick);
			dashObj.wheel_size_btn.addEventListener(MouseEvent.CLICK , wheelSizeClick);
			dashObj.wheel_category_btn.addEventListener(MouseEvent.CLICK , wheelCategoryClick);
			dashObj.vehicle_makes_btn.addEventListener(MouseEvent.CLICK , vehicleMakeClick);
			dashObj.model_years_btn.addEventListener(MouseEvent.CLICK , modelYearsClick);
			dashObj.background_btn.addEventListener(MouseEvent.CLICK , bgBtnClick);
			dashObj.settings_btn.addEventListener(MouseEvent.CLICK , settingsClick);
			dashObj.user_account_btn.addEventListener(MouseEvent.CLICK , userAccountClick);
			dashObj.coordinate_btn.addEventListener(MouseEvent.CLICK , userCoordinatesClick);
		}

		function manufacturerClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadManufactFrm("manufacturer-frm.swf");
		}
		function accessoryTypeClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadAccoessoryTypeFrm("part-types-frm.swf");
		}
		function accessoryCatClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadPartCategoryFrm("part-category-frm.swf");
		}
		function wheelSizeClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadWheelSizesFrm("wheel-sizes.swf");
		}
		function wheelCategoryClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadWheelCategoryFrm("wheel-categories.swf");
		}
		function vehicleMakeClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadMkFrm("grid-mk.swf");
		}
		function modelYearsClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadYearFrm("years-frm.swf");
		}
		function bgBtnClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadBgFrm("grid-bg.swf");
		}
		public function settingsClick(e:MouseEvent):void {
			wallCls.buildBlackWall();
			loadSettingsFrm("settings.swf");
		}
		function userAccountClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadUserFrm("user-account.swf");
		}

		function userCoordinatesClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadCoordinatesFrm("coordinates.swf");
		}

		/*
		********************************************************
		Wizard Form
		*/

		function adNewPartBtnClick(e:MouseEvent) {
			wallCls.buildBlackWall();
			loadMakeGrid("grid-makes.swf");
		}

		/* STEP#1    (_make grid)  */
		function loadMakeGrid(url:String) {
			makeGrdLr = new Loader();
			makeGrdLr.load(new URLRequest(url));
			makeGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, makeGridLoaded);
			loaderCls.pleaseWait("Loading Vehicles Make Form...");
		}
		function makeGridLoaded(e:Event):void {
			makeGrdMC = new MovieClip();
			makeGrdMC=e.currentTarget.content as MovieClip;

			addChild(makeGrdMC);
			makeGrdMC.x=200;
			makeGrdMC.y=100;

			makeGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onMakeGridClose );
			makeGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onMakeGridSelect );
			loaderCls.endWait();
		}
		function onMakeGridSelect(event:MouseEvent) {
			if (makeGrdMC.MAKE_ID==0) {
				makeGrdMC.setMessages(true, "Please select vehicle make first!");
			} else {
				$make_id = makeGrdMC.MAKE_ID;
				$make_name = makeGrdMC.MAKE_NAME;

				MovieClip(parent).breadCls.breadObj.makeTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.makeTxt.text=$make_name;

				removeMakeGrd();

				//chain
				loadModelGrid("grid-models.swf");
			}
		}
		function onMakeGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeMakeGrd();
		}
		function removeMakeGrd() {
			makeGrdLr.unload();
			removeChild(makeGrdMC);
			makeGrdMC=null;
		}


		/* STEP#2    (_model grid)  */
		function loadModelGrid(url:String) {
			modelGrdLr = new Loader();
			modelGrdLr.load(new URLRequest(url));
			modelGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, modelGridLoaded);
			loaderCls.pleaseWait("Loading Vehicles Models Form...");
		}
		function modelGridLoaded(e:Event):void {
			modelGrdMC = new MovieClip();
			modelGrdMC=e.currentTarget.content as MovieClip;

			addChild(modelGrdMC);
			modelGrdMC.x=200;
			modelGrdMC.y=100;

			modelGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onModelGridSelect );
			modelGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onModelGridClose );
			modelGrdMC.backStepBtn.addEventListener(MouseEvent.CLICK, onModelFrmBack );

			//send filter values
			modelGrdMC.make_id_txt.text=$make_id;

			loaderCls.endWait();
		}
		function onModelFrmBack(event:MouseEvent) {
			loadMakeGrid("grid-makes.swf");
			removeModelGrd();
		}
		function onModelGridSelect(event:MouseEvent) {
			if (modelGrdMC.MODEL_ID==0) {
				modelGrdMC.setMessages(true, "Please select vehicle model first!");
			} else {
				$year_id=modelGrdMC.YEAR_ID;
				$year_title=modelGrdMC.YEAR_TITLE;
				$model_id=modelGrdMC.MODEL_ID;
				$model_title=modelGrdMC.MODEL_TITLE;

				MovieClip(parent).breadCls.breadObj.yearTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.modelTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.yearTxt.text=$year_title;
				MovieClip(parent).breadCls.breadObj.modelTxt.text=$model_title;

				removeModelGrd();

				//chain
				loadTrimGrid("grid-trims.swf");
			}
		}

		function onModelGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeModelGrd();
		}
		function removeModelGrd() {
			modelGrdLr.unload();
			removeChild(modelGrdMC);
			modelGrdMC=null;
		}




		/* STEP#3   ( _trim grid ) */
		function loadTrimGrid(url:String) {
			trimGrdLr = new Loader();
			trimGrdLr.load(new URLRequest(url));
			trimGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, trimGridLoaded);
			loaderCls.pleaseWait("Loading Vehicle Models Trim Grid...");
			addChild(loaderCls);
		}
		function trimGridLoaded(e:Event):void {
			trimGrdMC = new MovieClip();
			trimGrdMC=e.currentTarget.content as MovieClip;
			addChild(trimGrdMC);
			trimGrdMC.x=200;
			trimGrdMC.y=230;

			trimGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onTrimGridSelect );
			trimGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onTrimGridClose );
			trimGrdMC.backStepBtn.addEventListener(MouseEvent.CLICK, onTrimFrmBack );

			//send filter values
			trimGrdMC.model_id_txt.text=$model_id;

			loaderCls.endWait();
		}

		function onTrimFrmBack(event:MouseEvent) {
			loadModelGrid("grid-models.swf");
			removeTrimGrd();
		}

		function onTrimGridSelect(event:MouseEvent) {
			if (trimGrdMC.TRIM_ID==0) {
				trimGrdMC.setMessages(true, "Please select vehicle model's trim first!");
			} else {
				$trim_id=trimGrdMC.TRIM_ID;
				$trim_title=trimGrdMC.TRIM_TITLE;
				Main.trimID=$trim_id;

				MovieClip(parent).breadCls.breadObj.trimTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.trimTxt.text=$trim_title;
				removeTrimGrd();

				//chain
				loadExteriorGrid("grid-exterior.swf");
			}
		}

		function onTrimGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeTrimGrd();
		}
		function removeTrimGrd() {
			trimGrdLr.unload();
			removeChild(trimGrdMC);
			trimGrdMC=null;
		}


		/* STEP#4      ( _exterior color  ) */
		function loadExteriorGrid(url:String) {
			exteriorGrdLr = new Loader();
			exteriorGrdLr.load(new URLRequest(url));
			exteriorGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, exteriorGridLoaded);
			loaderCls.pleaseWait("Loading Vehicles Exterior Colors Grid...");
			addChild(loaderCls);
		}
		function exteriorGridLoaded(e:Event):void {
			exteriorGrdMC = new MovieClip();
			exteriorGrdMC=e.currentTarget.content as MovieClip;

			addChild(exteriorGrdMC);
			exteriorGrdMC.x=200;
			exteriorGrdMC.y=130;

			exteriorGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onExteriorGridSelect );
			exteriorGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onExteriorGridClose );
			exteriorGrdMC.backStepBtn.addEventListener(MouseEvent.CLICK, onExteriorFrmBack );

			//send filter values
			exteriorGrdMC.trim_id_txt.text=$trim_id;

			loaderCls.endWait();
		}
		function onExteriorFrmBack(event:MouseEvent) {
			loadTrimGrid("grid-trims.swf");
			removeExteriorGrd();
		}
		function onExteriorGridSelect(event:MouseEvent) {
			if (exteriorGrdMC.EXTERIOR_ID==0) {
				exteriorGrdMC.setMessages(true, "Please select vehicle exterior color first!");
			} else {
				$exterior_color_id=exteriorGrdMC.EXTERIOR_ID;
				$exterior_color_title=exteriorGrdMC.EXTERIOR_TITLE;
				Main.exteriorColorID=$exterior_color_id;

				MovieClip(parent).breadCls.breadObj.exteriorTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.exteriorTxt.text=$exterior_color_title;
				removeExteriorGrd();

				//chain
				loadInteriorGrid("grid-interior.swf");
			}
		}
		function onExteriorGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeExteriorGrd();
		}
		function removeExteriorGrd() {
			exteriorGrdLr.unload();
			removeChild(exteriorGrdMC);
			exteriorGrdMC=null;
		}

		/* STEP#5    (    _interior color  ) */
		function loadInteriorGrid(url:String) {
			interiorGrdLr = new Loader();
			interiorGrdLr.load(new URLRequest(url));
			interiorGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, interiorGridLoaded);
			loaderCls.pleaseWait("Loading Vehicle Interior Colors Grid...");
			addChild(loaderCls);
		}
		function interiorGridLoaded(e:Event):void {
			interiorGrdMC = new MovieClip();
			interiorGrdMC=e.currentTarget.content as MovieClip;

			addChild(interiorGrdMC);
			interiorGrdMC.x=200;
			interiorGrdMC.y=130;

			interiorGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onInteriorGridSelect );
			interiorGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onInteriorGridClose );
			interiorGrdMC.backStepBtn.addEventListener(MouseEvent.CLICK, onInteriorFrmBack );

			//send filter values
			interiorGrdMC.trim_id_txt.text=$trim_id;

			loaderCls.endWait();
		}
		function onInteriorFrmBack(event:MouseEvent) {
			loadExteriorGrid("grid-exterior.swf");
			removeInteriorGrd();
		}
		function onInteriorGridSelect(event:MouseEvent) {
			if (interiorGrdMC.EXTERIOR_ID==0) {
				interiorGrdMC.setMessages(true, "Please select vehicle interior color first!");
			} else {
				$interior_color_id=interiorGrdMC.INTERIOR_ID;
				$interior_color_title=interiorGrdMC.INTERIOR_TITLE;
				Main.interiorColorID=$interior_color_id;

				MovieClip(parent).breadCls.breadObj.interiorTxt.defaultTextFormat=MainTextFormat.setBreadCrumbFormat();
				MovieClip(parent).breadCls.breadObj.interiorTxt.text=$interior_color_title;
				removeInteriorGrd();

				//chain
				loadViewGrid("grid-views.swf");

			}
		}
		function onInteriorGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeInteriorGrd();
		}
		function removeInteriorGrd() {
			interiorGrdLr.unload();
			removeChild(interiorGrdMC);
			interiorGrdMC=null;
		}


		/* STEP#6    (  _view grid  )*/
		function loadViewGrid(url:String) {
			viewGrdLr = new Loader();
			viewGrdLr.load(new URLRequest(url));
			viewGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, viewGridLoaded);
			loaderCls.pleaseWait("Loading Vehicle View Form...");
			addChild(loaderCls);
		}
		function viewGridLoaded(e:Event):void {
			viewGrdMC = new MovieClip();
			viewGrdMC=e.currentTarget.content as MovieClip;

			addChild(viewGrdMC);
			viewGrdMC.x=200;
			viewGrdMC.y=40;

			viewGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onViewGridSelect );
			viewGrdMC.PanelMC.bg_btn.addEventListener(MouseEvent.CLICK, onSelectBg );
			viewGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onViewGridClose );
			viewGrdMC.backStepBtn.addEventListener(MouseEvent.CLICK, onViewFrmBack );


			//send filter values
			viewGrdMC.trim_id_txt.text=$trim_id;
			viewGrdMC.exterior_id_txt.text=$exterior_color_id;
			viewGrdMC.interior_id_txt.text=$interior_color_id;

			loaderCls.endWait();
		}
		function onViewFrmBack(event:MouseEvent) {
			loadInteriorGrid("grid-interior.swf");
			removeViewGrd();
		}

		function onViewGridSelect(event:MouseEvent) {
			$vehicle_id=Number(viewGrdMC.vehicle_id_txt.text);
			Main.vehicleID=$vehicle_id;

			removeViewGrd();

			wallCls.removeBlackWall();
			//FINAL (gotoNextFrame)
			MovieClip(parent).buildWorkspace();
		}

		function onViewGridClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeViewGrd();
		}
		function removeViewGrd() {
			viewGrdLr.unload();
			removeChild(viewGrdMC);
			viewGrdMC=null;
		}

		function onSelectBg(event:MouseEvent) {
			loadBgGrid("grid-background.swf");
		}



		/*  STEP#7  (_backgrounds )  */
		function loadBgGrid(url:String) {
			bgGrdLr = new Loader();
			bgGrdLr.load(new URLRequest(url));
			bgGrdLr.contentLoaderInfo.addEventListener(Event.COMPLETE, bgGridLoaded);
		}
		function bgGridLoaded(e:Event):void {
			bgGrdMC = new MovieClip();
			bgGrdMC=e.currentTarget.content as MovieClip;
			bgGrdLr.unload();

			addChild(bgGrdMC);
			bgGrdMC.x=200;
			bgGrdMC.y=130;

			bgGrdMC.vehicle_id_txt.text=viewGrdMC.VEHICLE_ID;
			bgGrdMC.select_btn.addEventListener(MouseEvent.CLICK, onBgGridSelect );
			bgGrdMC.close_btn.addEventListener(MouseEvent.CLICK, onBgGridClose );
			
		}
		function onBgGridSelect(event:MouseEvent) {
			if (bgGrdMC.BACKGROUND_ID==0) {
				bgGrdMC.setMessages(true, "Please select vehicle interior color first!");
			} else {
				updateCanvesBackground( Number(viewGrdMC.vehicle_id_txt.text), Number(bgGrdMC.BACKGROUND_ID) );
				removeBgGrd();
				removeViewGrd();
				loadViewGrid("grid-views.swf");
			}
		}
		function onBgGridClose(event:MouseEvent) {
			removeBgGrd();
		}
		function removeBgGrd() {
			removeChild(bgGrdMC);
			bgGrdMC=null;
		}






		/*
		********************************************************
		Other Form
		*/

		/* ( Wheel Category Form ) */
		function loadWheelCategoryFrm(url:String) {
			wheelCatLr = new Loader();
			wheelCatLr.load(new URLRequest(url));
			wheelCatLr.contentLoaderInfo.addEventListener(Event.COMPLETE, wheelCatFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Wheel Categories Form...");
		}
		function wheelCatFrmLoaded(e:Event):void {
			wheelCatFrmMC = new MovieClip();
			wheelCatFrmMC=e.currentTarget.content as MovieClip;

			addChild(wheelCatFrmMC);
			wheelCatFrmMC.x=330;
			wheelCatFrmMC.y=170;

			wheelCatFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onWheelCatFrmClose );
			loaderCls.endWait();
		}
		function onWheelCatFrmClose(event:MouseEvent) {
			removeWheelCatFrm();
		}
		function removeWheelCatFrm() {
			wheelCatLr.unload();
			removeChild(wheelCatFrmMC);
			wheelCatFrmMC=null;
			wallCls.removeBlackWall();
		}

		/* ( Wheel Sizes Form ) */
		function loadWheelSizesFrm(url:String) {
			wheelSizeLr = new Loader();
			wheelSizeLr.load(new URLRequest(url));
			wheelSizeLr.contentLoaderInfo.addEventListener(Event.COMPLETE, wheelSizeFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Wheel Sizes Form...");
		}
		function wheelSizeFrmLoaded(e:Event):void {
			wheelSizeFrmMC = new MovieClip();
			wheelSizeFrmMC=e.currentTarget.content as MovieClip;

			addChild(wheelSizeFrmMC);
			wheelSizeFrmMC.x=330;
			wheelSizeFrmMC.y=250;

			wheelSizeFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onWheelSizeFrmClose );
			loaderCls.endWait();
		}
		function onWheelSizeFrmClose(event:MouseEvent) {
			removeWheelSizeFrm();
		}
		function removeWheelSizeFrm() {
			wheelSizeLr.unload();
			removeChild(wheelSizeFrmMC);
			wheelSizeFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*( Part Categories Form )*/
		function loadPartCategoryFrm(url:String) {
			partCatFrmLr = new Loader();
			partCatFrmLr.load(new URLRequest(url));
			partCatFrmLr.contentLoaderInfo.addEventListener(Event.COMPLETE, partCatFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Accessory Categories Form...");
		}
		function partCatFrmLoaded(e:Event):void {
			partCatFrmMC = new MovieClip();
			partCatFrmMC=e.currentTarget.content as MovieClip;

			addChild(partCatFrmMC);
			partCatFrmMC.x=330;
			partCatFrmMC.y=170;

			partCatFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onPartCatFrmClose );
			loaderCls.endWait();
		}
		function onPartCatFrmClose(event:MouseEvent) {
			removePartCatFrm();
		}
		function removePartCatFrm() {
			partCatFrmLr.unload();
			removeChild(partCatFrmMC);
			partCatFrmMC=null;
			wallCls.removeBlackWall();
		}

		/* ( Accessory Type Form ) */
		function loadAccoessoryTypeFrm(url:String) {
			partTypeFrmLr = new Loader();
			partTypeFrmLr.load(new URLRequest(url));
			partTypeFrmLr.contentLoaderInfo.addEventListener(Event.COMPLETE, accoessoryTypeFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Accessory Types Form...");
		}
		function accoessoryTypeFrmLoaded(e:Event):void {
			partTypeFrmMC = new MovieClip();
			partTypeFrmMC=e.currentTarget.content as MovieClip;

			addChild(partTypeFrmMC);
			partTypeFrmMC.x=330;
			partTypeFrmMC.y=250;

			partTypeFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onAccoessoryFrmClose );
			loaderCls.endWait();
		}
		function onAccoessoryFrmClose(event:MouseEvent) {
			removeAccoessoryTypeFrm();
		}
		function removeAccoessoryTypeFrm() {
			partTypeFrmLr.unload();
			removeChild(partTypeFrmMC);
			partTypeFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*( Manufacturer Form )*/
		function loadManufactFrm(url:String) {
			manufacturerLr = new Loader();
			manufacturerLr.load(new URLRequest(url));
			manufacturerLr.contentLoaderInfo.addEventListener(Event.COMPLETE, manufactFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Accessory Manufacturers Form...");
		}
		function manufactFrmLoaded(e:Event):void {
			manufacturerFrmMC = new MovieClip();
			manufacturerFrmMC=e.currentTarget.content as MovieClip;

			addChild(manufacturerFrmMC);
			manufacturerFrmMC.x=330;
			manufacturerFrmMC.y=250;

			manufacturerFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onManufactFrmClose );
			loaderCls.endWait();
		}
		function onManufactFrmClose(event:MouseEvent) {
			removeManufactFrm();
		}
		function removeManufactFrm() {
			manufacturerLr.unload();
			removeChild(manufacturerFrmMC);
			manufacturerFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*( Years Form )*/
		function loadYearFrm(url:String) {
			yearLr = new Loader();
			yearLr.load(new URLRequest(url));
			yearLr.contentLoaderInfo.addEventListener(Event.COMPLETE, yearFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicle Years Form...");
		}
		function yearFrmLoaded(e:Event):void {
			yearFrmMC = new MovieClip();
			yearFrmMC=e.currentTarget.content as MovieClip;

			addChild(yearFrmMC);
			yearFrmMC.x=330;
			yearFrmMC.y=250;

			yearFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onYearFrmClose );
			loaderCls.endWait();
		}

		function onYearFrmClose(event:MouseEvent) {
			removeYearFrm();
		}
		function removeYearFrm() {
			yearLr.unload();
			removeChild(yearFrmMC);
			yearFrmMC=null;
			wallCls.removeBlackWall();
		}


		/*( Settings Form )*/
		function loadSettingsFrm(url:String) {
			settingLr = new Loader();
			settingLr.load(new URLRequest(url));
			settingLr.contentLoaderInfo.addEventListener(Event.COMPLETE, settingsFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicles Settings Form...");
		}
		function settingsFrmLoaded(e:Event):void {
			settingFrmMC = new MovieClip();
			settingFrmMC=e.currentTarget.content as MovieClip;

			addChild(settingFrmMC);
			settingFrmMC.x=280;
			settingFrmMC.y=130;

			settingFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onSettingsFrmClose );
			settingFrmMC.submit_btn.addEventListener(MouseEvent.CLICK, onSubmitSettingsFrm );
			loaderCls.endWait();
		}

		function onSubmitSettingsFrm(event:MouseEvent) {
			if (settingFrmMC.validateFrm()) {
				settingFrmMC.saveSettings();
				settingFrmMC.msg_txt.visible=true;
				settingFrmMC.msg_txt.text="Save configurations settings successfully.";
			} else {
				settingFrmMC.msg_txt.visible=true;
			}
		}

		function onSettingsFrmClose(event:MouseEvent) {
			removeSettingsFrm();
			wallCls.removeBlackWall();
		}
		function removeSettingsFrm() {
			settingLr.unload();
			removeChild(settingFrmMC);
			settingFrmMC=null;
		}

		/*( User Account Form )*/
		function loadUserFrm(url:String) {
			userLr = new Loader();
			userLr.load(new URLRequest(url));
			userLr.contentLoaderInfo.addEventListener(Event.COMPLETE, userFrmLoaded);
			loaderCls.pleaseWait("Loading User Accounts Form...");
		}
		function userFrmLoaded(e:Event):void {
			userFrmMC = new MovieClip();
			userFrmMC=e.currentTarget.content as MovieClip;

			addChild(userFrmMC);
			userFrmMC.x=330;
			userFrmMC.y=250;

			userFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onUserFrmClose );
			loaderCls.endWait();
		}

		function onUserFrmClose(event:MouseEvent) {
			removeUserFrm();
		}
		function removeUserFrm() {
			userLr.unload();
			removeChild(userFrmMC);
			userFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*( Background Form )*/
		function loadBgFrm(url:String) {
			bgLr = new Loader();
			bgLr.load(new URLRequest(url));
			bgLr.contentLoaderInfo.addEventListener(Event.COMPLETE, bgFrmLoaded);
			loaderCls.pleaseWait("Loading Deal Presentations Canves Backgrounds Form...");
		}
		function bgFrmLoaded(e:Event):void {
			bgFrmMC = new MovieClip();
			bgFrmMC=e.currentTarget.content as MovieClip;

			addChild(bgFrmMC);
			bgFrmMC.x=200;
			bgFrmMC.y=100;

			bgFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onBgFrmClose );
			loaderCls.endWait();
		}

		function onBgFrmClose(event:MouseEvent) {
			removeBgFrm();
		}
		function removeBgFrm() {
			bgLr.unload();
			removeChild(bgFrmMC);
			bgFrmMC=null;
			wallCls.removeBlackWall();
		}


		/*( Make Form )*/
		function loadMkFrm(url:String) {
			mkLr = new Loader();
			mkLr.load(new URLRequest(url));
			mkLr.contentLoaderInfo.addEventListener(Event.COMPLETE, mkFrmLoaded);
			loaderCls.pleaseWait("Loading Vehicle Makes Form...");
		}
		function mkFrmLoaded(e:Event):void {
			mkFrmMC = new MovieClip();
			mkFrmMC=e.currentTarget.content as MovieClip;

			addChild(mkFrmMC);
			mkFrmMC.x=200;
			mkFrmMC.y=100;

			mkFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onMkFrmClose );
			loaderCls.endWait();
		}

		function onMkFrmClose(event:MouseEvent) {
			removeMkFrm();
		}
		function removeMkFrm() {
			mkLr.unload();
			removeChild(mkFrmMC);
			mkFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*( Coordinates Form )*/
		function loadCoordinatesFrm(url:String) {
			coordinatesLr = new Loader();
			coordinatesLr.load(new URLRequest(url));
			coordinatesLr.contentLoaderInfo.addEventListener(Event.COMPLETE, mkCoordFrmLoaded);
			loaderCls.pleaseWait("Loading Deal Presenation Playground Coordinates Form...");
		}
		function mkCoordFrmLoaded(e:Event):void {
			coordFrmMC = new MovieClip();
			coordFrmMC=e.currentTarget.content as MovieClip;

			addChild(coordFrmMC);
			coordFrmMC.x=300;
			coordFrmMC.y=150;

			coordFrmMC.close_btn.addEventListener(MouseEvent.CLICK, onCoordFrmClose );
			coordFrmMC.submit_btn.addEventListener(MouseEvent.CLICK, onCoordFrmSubmit );
			loaderCls.endWait();
		}
		function onCoordFrmSubmit(event:MouseEvent) {
			if (coordFrmMC.validateFrm()) {
				updateCoordinates(encodeCoordinates(coordFrmMC.sfviewx_txt.text,coordFrmMC.sfviewy_txt.text,coordFrmMC.srviewx_txt.text,coordFrmMC.srviewy_txt.text,coordFrmMC.siviewx_txt.text,coordFrmMC.siviewy_txt.text,
				coordFrmMC.cfviewx_txt.text,coordFrmMC.cfviewy_txt.text,coordFrmMC.crviewx_txt.text,coordFrmMC.crviewy_txt.text,coordFrmMC.civiewx_txt.text,coordFrmMC.civiewy_txt.text));
			} else {
				trace("Please fill all fields");
			}
		}
		function onCoordFrmClose(event:MouseEvent) {
			removeCoordFrm();
		}
		function removeCoordFrm() {
			coordinatesLr.unload();
			removeChild(coordFrmMC);
			mkFrmMC=null;
			wallCls.removeBlackWall();
		}

		/*
		**************************************************************************************
		Remotings
		*/
		/* update coordinates */
		function encodeCoordinates(sfviewx,sfviewy,srviewx,srviewy,siviewx,siviewy,cfviewx,cfviewy,crviewx,crviewy,civiewx,civiewy):String {
			var tempArr:Array = new Array();
			var obj:Object = new Object();
			obj.SFVIEWX=sfviewx;
			obj.SFVIEWY=sfviewy;
			obj.SRVIEWX=srviewx;
			obj.SRVIEWY=srviewy;
			obj.SIVIEWX=siviewx;
			obj.SIVIEWY=siviewy;
			obj.CFVIEWX=cfviewx;
			obj.CFVIEWY=cfviewy;
			obj.CRVIEWX=crviewx;
			obj.CRVIEWY=crviewy;
			obj.CIVIEWX=civiewx;
			obj.CIVIEWY=civiewy;
			tempArr.push(obj);
			return JSON.encode(tempArr);
		}
		function updateCoordinates($string:String) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(update_coordinates_result,onFault);
			_service.call("AddOnCars.setVariable", responder , 'default_coordinates',$string);
		}
		function update_coordinates_result(rs:Object) {
			//trace(rs);
		}

		//update canves background
		function updateCanvesBackground($vid:Number , $bg_id:Number) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(update_canvesbackground_result,onFault);
			_service.call("AddOnCars.updateCanvesBackground", responder , $vid , $bg_id );
		}
		function update_canvesbackground_result(rs:Object) {
			//trace(rs);
		}

		// error handler
		function onFault(f:Event ) {
			trace("There was a problem");
		}

		/*
		*********************************************************************************************************************************
		set Dashboard values
		*/
		public function setDashConfiguration():void {
			with (dashObj) {
				domain_txt.text=Main.hostDomain;
				gateway_txt.text=Main.gateWay;
				uploadscript_txt.text=Main.uploadScript;
				effect_txt.text=Main.effectAccessoriesFiles;
				icon_txt.text=Main.accessoriesIconFiles;
				smallview_txt.text=Main.smallViewsFiles;
				canvesview_txt.text=Main.canvesViewsFiles;
				bg_txt.text=Main.backgroundFiles;
				interiorcolor_txt.text="None";
			}
		}



	}//$class
}//$package