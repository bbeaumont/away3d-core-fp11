package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	/**
	 * Defines a single segment of a cubic path
	 * @see away3d.extrusions.utils.CubicPath
	 */
	public class CubicPathSegment implements IPathSegment
	{
		/**
		 * The first anchor point.
		 */
		public var pStart:Vector3D;

		/**
		 * The first control point.
		 */
		public var pControl1:Vector3D;

		/**
		 * The second control point.
		 */
		public var pControl2:Vector3D;

		/**
		 * The last anchor point.
		 */
		public var pEnd:Vector3D;


		/**
		 *
		 * @param pStart The first anchor point.
		 * @param pControl1 The first control point.
		 * @param pControl2 The second control point.
		 * @param pEnd The last anchor point.
		 */
		public function CubicPathSegment(pStart:Vector3D, pControl1:Vector3D, pControl2:Vector3D, pEnd:Vector3D)
		{
			this.pStart = pStart;
			this.pControl1 = pControl1;
			this.pControl2 = pControl2;
			this.pEnd = pEnd;
		}


		public function toString():String
		{
			return pStart + ", " + pControl1 + ", " + pControl2 + ", " + pEnd;
		}


		public function dispose():void
		{
			pStart = pControl1 = pControl2 = pEnd = null;
		}

	}
}
