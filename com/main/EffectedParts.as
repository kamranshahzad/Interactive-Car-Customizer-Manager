package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import com.parts.*;


	public class EffectedParts extends MovieClip {

		public var partObj:Parts;

		public var frontImgSrc:String='';
		public var rearImgSrc:String='';
		public var interiorImgSrc:String='';
		public var otherImgSrc:String='';
		public var FVIEWImgSrc:String='';
		public var RVIEWImgSrc:String='';
		public var IVIEWImgSrc:String='';

		public var frontUrl:URLRequest;
		public var rearUrl:URLRequest;
		public var interiorUrl:URLRequest;
		public var otherUrl:URLRequest;
		public var FVIEWUrl:URLRequest;
		public var RVIEWUrl:URLRequest;
		public var IVIEWUrl:URLRequest;

		public var frontRef:FileReference;
		public var rearRef:FileReference;
		public var interiorRef:FileReference;
		public var otherRef:FileReference;

		public var FVIEWRef:FileReference;
		public var RVIEWRef:FileReference;
		public var IVIEWRef:FileReference;

		var imagesFilter:FileFilter=new FileFilter("Images","*.png");

		public function EffectedParts() {

			frontImgSrc='';
			rearImgSrc='';
			interiorImgSrc='';
			otherImgSrc='';
			FVIEWImgSrc='';
			RVIEWImgSrc='';
			IVIEWImgSrc='';

			frontRef = new FileReference();
			rearRef = new FileReference();
			interiorRef = new FileReference();
			otherRef = new FileReference();

			FVIEWRef = new FileReference();
			RVIEWRef = new FileReference();
			IVIEWRef = new FileReference();


			frontRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, frontPartUploadComplete );
			rearRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, rearPartUploadComplete );
			interiorRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, interiorPartUploadComplete );
			otherRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, otherPartUploadComplete );

			FVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, FVIEWPartUploadComplete );
			RVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, RVIEWPartUploadComplete );
			IVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, IVIEWPartUploadComplete );


			//add parts
			partObj = new Parts();
			addChild(partObj);
		}

		/*    Browse Buttons Workers  */
		function brosweFrontHandler() {
			frontRef.browse([imagesFilter]);
			frontRef.addEventListener(Event.SELECT, selectFrontPart );
		}
		function brosweRearHandler() {
			rearRef.browse([imagesFilter]);
			rearRef.addEventListener(Event.SELECT, selectRearPart );
		}
		function brosweInteriorHandler() {
			interiorRef.browse([imagesFilter]);
			interiorRef.addEventListener(Event.SELECT, selectInteriorPart );
		}
		function brosweOtherHandler() {
			otherRef.browse([imagesFilter]);
			otherRef.addEventListener(Event.SELECT, selectOtherPart );
		}


		function brosweFVIEWHandler() {
			FVIEWRef.browse([imagesFilter]);
			FVIEWRef.addEventListener(Event.SELECT, selectFVIEWPart );
		}
		function brosweRVIEWHandler() {
			RVIEWRef.browse([imagesFilter]);
			RVIEWRef.addEventListener(Event.SELECT, selectRVIEWPart );
		}
		function brosweIVIEWHandler() {
			IVIEWRef.browse([imagesFilter]);
			IVIEWRef.addEventListener(Event.SELECT, selectIVIEWPart );
		}


		/*  FRONT*/
		function selectFrontPart(e:Event):void {
			frontUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			frontRef.upload(frontUrl);
		}
		function frontPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				frontImgSrc = e.data;
				partObj.startFrontClips(frontImgSrc);
				frontRef=null;
				MovieClip(parent).brosweBtnCls.destroyFrontViewButton();
			}
		}
		public function resetFrontPart():void{
			frontImgSrc = '';
			frontRef = new FileReference();
			frontRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, frontPartUploadComplete );
		}
		


		/*  REAR */
		function selectRearPart(e:Event):void {
			rearUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			rearRef.upload(rearUrl);
		}
		function rearPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				rearImgSrc=e.data;
				partObj.startRearClips(rearImgSrc);
				rearRef=null;
				MovieClip(parent).brosweBtnCls.destroyRearViewButton();
			}
		}
		public function resetRearPart():void{
			rearImgSrc = '';
			rearRef = new FileReference();
			rearRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, rearPartUploadComplete );
		}

		/*  Interior  */
		function selectInteriorPart(e:Event):void {
			interiorUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			interiorRef.upload(interiorUrl);
		}
		function interiorPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				interiorImgSrc=e.data;
				partObj.startInteriorClips(interiorImgSrc);
				interiorRef=null;
				MovieClip(parent).brosweBtnCls.destroyInteriorViewButton();
			}
		}
		public function resetInteriorPart():void{
			interiorImgSrc = '';
			interiorRef = new FileReference();
			interiorRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, interiorPartUploadComplete );
		}

		/*  Other  */
		function selectOtherPart(e:Event):void {
			otherUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			otherRef.upload(otherUrl);
		}
		function otherPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				otherImgSrc=e.data;
				partObj.startOtherClips(otherImgSrc);
				otherRef=null;
				MovieClip(parent).brosweBtnCls.destroyOtherViewButton();
			}
		}
		public function resetOtherPart():void{
			otherImgSrc = '';
			otherRef = new FileReference();
			otherRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, otherPartUploadComplete );
		}

		/*  FVIEW  */
		function selectFVIEWPart(e:Event):void {
			FVIEWUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			FVIEWRef.upload(FVIEWUrl);
		}
		function FVIEWPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				FVIEWImgSrc=e.data;
				partObj.startFVIEWClips(FVIEWImgSrc);
				FVIEWRef=null;
				MovieClip(parent).brosweBtnCls.destroyFViewButton();
			}
		}
		public function resetFVIEWPart():void{
			FVIEWImgSrc = '';
			FVIEWRef = new FileReference();
			FVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, FVIEWPartUploadComplete );
		}

		/*  RVIEW  */
		function selectRVIEWPart(e:Event):void {
			RVIEWUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			RVIEWRef.upload(RVIEWUrl);
		}
		function RVIEWPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				RVIEWImgSrc=e.data;
				partObj.startRVIEWClips(RVIEWImgSrc);
				RVIEWRef=null;
				MovieClip(parent).brosweBtnCls.destroyRViewButton();
			}
		}
		public function resetRVIEWPart():void{
			RVIEWImgSrc = '';
			RVIEWRef = new FileReference();
			RVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, RVIEWPartUploadComplete );
		}

		/*  IVIEW  */
		function selectIVIEWPart(e:Event):void {
			IVIEWUrl=new URLRequest(Main.uploadScript+"?uploadDir=effected");
			IVIEWRef.upload(IVIEWUrl);
		}
		function IVIEWPartUploadComplete(e:DataEvent):void {
			if (partObj) {
				IVIEWImgSrc = e.data;
				partObj.startIVIEWClips(IVIEWImgSrc);
				IVIEWRef=null;
				MovieClip(parent).brosweBtnCls.destroyIViewButton();
			}
		}
		public function resetIVIEWPart():void{
			IVIEWImgSrc = '';
			IVIEWRef = new FileReference();
			IVIEWRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, IVIEWPartUploadComplete );
		}


	}//$class
}//$package