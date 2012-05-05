/**
 * User: benbeaumont
 * Date: 05/05/2012
 */
package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	/**
	 * Defines a cubic path. Each segment of the path has two control points as opposed to <code>PathSegment</code> which being quadratic, has one control point.
	 * @see away3d.animators.CubicPathAnimator
	 * @see away3d.extrusions.utils.CubicPathSegment
	 */
	public class CubicPath
	{
		private static const POINTS_PER_SEGMENT:int = 4;

		private var _segments:Vector.<CubicPathSegment>;
		private var _worldAxis:Vector3D;


		/**
		 * Creates a new CubicPath instance.
		 * @param data See <code>pointData</code>
		 */
		public function CubicPath(data:Vector.<Vector3D> = null)
		{
			pointData = data;
			_worldAxis = new Vector3D(0.0, 1.0, 0.0);
		}


		/**
		 * A list of <code>Vector3D</code> objects, which must be in the following order:
		 * a1, b1, c1, d1, a2, b2, c2, d2 ... where a = start point, b = first control point, c = second control point and d = end control point.
		 * To avoid a broken path d1 and a2 must be equal.
		 */
		public function set pointData(data:Vector.<Vector3D>):void
		{
			if (data && data.length < POINTS_PER_SEGMENT)
				throw new Error('Cubic path must contain at least ' + POINTS_PER_SEGMENT + 'Vector3Ds');

			if (data.length%POINTS_PER_SEGMENT != 0)
				throw new Error('Cubic path data must contain a multiple of ' + POINTS_PER_SEGMENT + ' Vector3Ds');

			_segments = new Vector.<CubicPathSegment>();

			if (data)
			{
				for (var i:int = 0, len:int = data.length; i < len; i += POINTS_PER_SEGMENT)
					_segments.push(new CubicPathSegment(data[i], data[i + 1], data[i + 2], data[i + 3]));
			}
		}


		/**
		 * The number of <code>CubicPathSegment</code> instances in the path.
		 */
		public function get length():uint
		{
			return _segments.length;
		}


		/**
		 * The <code>CubicPathSegment</code> instances which make up this path.
		 */
		public function get segments():Vector.<CubicPathSegment>
		{
			return _segments;
		}


		/**
		 * The world axis.
		 */
		public function get worldAxis():Vector3D
		{
			return _worldAxis;
		}


		public function set worldAxis(value:Vector3D):void
		{
			_worldAxis = value;
		}


		/**
		 * Returns the <code>CubicPathSegment</code> at the specified index
		 * @param index The index of the segment
		 * @return A <code>CubicPathSegment</code> instance
		 */
		public function getSegmentAt(index:uint):CubicPathSegment
		{
			return _segments[index];
		}


		/**
		 * Adds a <code>CubicPathSegment</code> to the end of the path
		 * @param segment
		 */
		public function add(segment:CubicPathSegment):void
		{
			_segments.push(segment);
		}


		/**
		 * Removes a segment from the path
		 * @param index The index of the <code>CubicPathSegment</code> to be removed
		 * @param join Determines if the segments on either side of the removed segment should be adjusted so there is no gap.
		 */
		public function remove(index:uint, join:Boolean = false):void
		{
			if (_segments.length == 0 || index >= _segments.length - 1)
				return;

			if (join && index < _segments.length - 1 && index > 0)
			{
				var seg:CubicPathSegment = _segments[index];
				var prevSeg:CubicPathSegment = _segments[index - 1];
				var nextSeg:CubicPathSegment = _segments[index + 1];

				prevSeg.control1.x = (prevSeg.control1.x + seg.control1.x)*0.5;
				prevSeg.control1.y = (prevSeg.control1.y + seg.control1.y)*0.5;
				prevSeg.control1.z = (prevSeg.control1.z + seg.control1.z)*0.5;

				nextSeg.control1.x = (nextSeg.control1.x + seg.control1.x)*0.5;
				nextSeg.control1.y = (nextSeg.control1.y + seg.control1.y)*0.5;
				nextSeg.control1.z = (nextSeg.control1.z + seg.control1.z)*0.5;

				prevSeg.control2.x = (prevSeg.control2.x + seg.control2.x)*0.5;
				prevSeg.control2.y = (prevSeg.control2.y + seg.control2.y)*0.5;
				prevSeg.control2.z = (prevSeg.control2.z + seg.control2.z)*0.5;

				nextSeg.control2.x = (nextSeg.control2.x + seg.control2.x)*0.5;
				nextSeg.control2.y = (nextSeg.control2.y + seg.control2.y)*0.5;
				nextSeg.control2.z = (nextSeg.control2.z + seg.control2.z)*0.5;

				prevSeg.end.x = (seg.start.x + seg.end.x)*0.5;
				prevSeg.end.y = (seg.start.y + seg.end.y)*0.5;
				prevSeg.end.z = (seg.start.z + seg.end.z)*0.5;

				nextSeg.start.x = prevSeg.end.x;
				nextSeg.start.y = prevSeg.end.y;
				nextSeg.start.z = prevSeg.end.z;
			}

			if (_segments.length > 1)
				_segments.splice(index, 1);
			else
				_segments = new Vector.<CubicPathSegment>();
		}


		/**
		 * Disposes the path and all the segments
		 */
		public function dispose():void
		{
			while (_segments.length > 0)
				_segments[0].dispose();
			_segments = null;
			_worldAxis = null;
		}
	}
}
