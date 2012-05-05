/**
 * User: benbeaumont
 * Date: 05/05/2012
 */
package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	public class CubicPathSegment
	{
		public var start:Vector3D;
		public var control1:Vector3D;
		public var control2:Vector3D;
		public var end:Vector3D;

		public function CubicPathSegment(start:Vector3D, control1:Vector3D, control2:Vector3D, end:Vector3D)
		{
			this.start = start;
			this.control1 = control1;
			this.control2 = control2;
			this.end = end;
		}


		public function toString():String
		{
			return start + ", " + control1 + ", " + control2 + ", " + end;
		}


		public function dispose():void
		{
			start = control1 = control2 = end = null;
		}

	}
}
