package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	public interface IPath
	{
		/**
		 * A list of <code>Vector3D</code> objects, which must be in the following order:
		 * a1, b1, c1, d1, a2, b2, c2, d2 ... where a = start point, b = first control point, c = second control point and d = end control point.
		 * To avoid a broken path d1 and a2 must be equal.
		 */
		function set pointData(data:Vector.<Vector3D>):void;


		/**
		 * The number of <code>CubicPathSegment</code> instances in the path.
		 */
		function get length():uint;


		/**
		 * The <code>CubicPathSegment</code> instances which make up this path.
		 */
		function get segments():Vector.<IPathSegment>;


		/**
		 * The world axis.
		 */
		function get worldAxis():Vector3D;


		function set worldAxis(value:Vector3D):void;


		/**
		 * Returns the <code>CubicPathSegment</code> at the specified index
		 * @param index The index of the segment
		 * @return A <code>CubicPathSegment</code> instance
		 */
		function getSegmentAt(index:uint):IPathSegment;


		/**
		 * Adds a <code>CubicPathSegment</code> to the end of the path
		 * @param segment
		 */
		function add(segment:IPathSegment):void;


		/**
		 * Removes a segment from the path
		 * @param index The index of the <code>CubicPathSegment</code> to be removed
		 * @param join Determines if the segments on either side of the removed segment should be adjusted so there is no gap.
		 */
		function remove(index:uint, join:Boolean = false):void;


		/**
		 * Disposes the path and all the segments
		 */
		function dispose():void;


		/**
		 * returns true if the smoothPath handler is being used.
		 */
		function get smoothed():Boolean;


		/**
		 * returns true if the averagePath handler is being used.
		 */
		function get averaged():Boolean;


		/**
		 * handler will smooth the path using anchors as control vector of the PathSegments
		 * note that this is not dynamic, the PathSegments values are overwrited
		 */
		function smoothPath():void;


		/**
		 * handler will average the path using averages of the PathSegments
		 * note that this is not dynamic, the path values are overwrited
		 */
		function averagePath():void;
	}
}
