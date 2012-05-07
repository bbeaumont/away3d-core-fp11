package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	/**
	 * Defines a cubic path. Each segment of the path has two control points as opposed to <code>PathSegment</code> which being quadratic, has one control point.
	 * @see away3d.animators.CubicPathAnimator
	 * @see away3d.extrusions.utils.CubicPathSegment
	 */
	public class CubicPath implements IPath
	{
		private static const POINTS_PER_SEGMENT:int = 4;

		private var _segments:Vector.<IPathSegment>;
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


		public function set pointData(data:Vector.<Vector3D>):void
		{
			if (data && data.length < POINTS_PER_SEGMENT)
				throw new Error('Cubic path must contain at least ' + POINTS_PER_SEGMENT + 'Vector3Ds');

			if (data.length%POINTS_PER_SEGMENT != 0)
				throw new Error('Cubic path data must contain a multiple of ' + POINTS_PER_SEGMENT + ' Vector3Ds');

			_segments = new Vector.<IPathSegment>();

			if (data)
			{
				for (var i:int = 0, len:int = data.length; i < len; i += POINTS_PER_SEGMENT)
					_segments.push(new CubicPathSegment(data[i], data[i + 1], data[i + 2], data[i + 3]));
			}
		}


		public function get length():uint
		{
			return _segments.length;
		}


		public function get segments():Vector.<IPathSegment>
		{
			return _segments;
		}


		public function get worldAxis():Vector3D
		{
			return _worldAxis;
		}


		public function set worldAxis(value:Vector3D):void
		{
			_worldAxis = value;
		}


		public function getSegmentAt(index:uint):IPathSegment
		{
			return _segments[index];
		}


		public function add(segment:IPathSegment):void
		{
			_segments.push(segment);
		}


		public function remove(index:uint, join:Boolean = false):void
		{
			if (_segments.length == 0 || index >= _segments.length - 1)
				return;

			if (join && index < _segments.length - 1 && index > 0)
			{
				var seg:CubicPathSegment = _segments[index] as CubicPathSegment;
				var prevSeg:CubicPathSegment = _segments[index - 1] as CubicPathSegment;
				var nextSeg:CubicPathSegment = _segments[index + 1] as CubicPathSegment;

				prevSeg.pControl1.x = (prevSeg.pControl1.x + seg.pControl1.x)*0.5;
				prevSeg.pControl1.y = (prevSeg.pControl1.y + seg.pControl1.y)*0.5;
				prevSeg.pControl1.z = (prevSeg.pControl1.z + seg.pControl1.z)*0.5;

				nextSeg.pControl1.x = (nextSeg.pControl1.x + seg.pControl1.x)*0.5;
				nextSeg.pControl1.y = (nextSeg.pControl1.y + seg.pControl1.y)*0.5;
				nextSeg.pControl1.z = (nextSeg.pControl1.z + seg.pControl1.z)*0.5;

				prevSeg.pControl2.x = (prevSeg.pControl2.x + seg.pControl2.x)*0.5;
				prevSeg.pControl2.y = (prevSeg.pControl2.y + seg.pControl2.y)*0.5;
				prevSeg.pControl2.z = (prevSeg.pControl2.z + seg.pControl2.z)*0.5;

				nextSeg.pControl2.x = (nextSeg.pControl2.x + seg.pControl2.x)*0.5;
				nextSeg.pControl2.y = (nextSeg.pControl2.y + seg.pControl2.y)*0.5;
				nextSeg.pControl2.z = (nextSeg.pControl2.z + seg.pControl2.z)*0.5;

				prevSeg.pEnd.x = (seg.pStart.x + seg.pEnd.x)*0.5;
				prevSeg.pEnd.y = (seg.pStart.y + seg.pEnd.y)*0.5;
				prevSeg.pEnd.z = (seg.pStart.z + seg.pEnd.z)*0.5;

				nextSeg.pStart.x = prevSeg.pEnd.x;
				nextSeg.pStart.y = prevSeg.pEnd.y;
				nextSeg.pStart.z = prevSeg.pEnd.z;
			}

			if (_segments.length > 1)
				_segments.splice(index, 1);
			else
				_segments = new Vector.<IPathSegment>();
		}


		public function dispose():void
		{
			while (_segments.length > 0)
				_segments[0].dispose();
			_segments = null;
			_worldAxis = null;
		}


		public function get smoothed():Boolean
		{
			return false;
		}


		public function get averaged():Boolean
		{
			return false;
		}


		public function smoothPath():void
		{
			// TODO - needs implementing
		}


		public function averagePath():void
		{
			// TODO - needs implementing
		}
	}
}
