// source: http://paulbourke.net/fractals/clifford/
class CliffordAttractor extends Attractor {
	float pA = -1.4;
	float pB = 1.6;
	float pC = 1;
	float pD = 0.7;
	NoiseVector nVec;

	CliffordAttractor() {
		name = "Clifford";
		lastPt = new PVector(0.1, 0.1);
		magFactor = 175;

		float[][] rangesCandD = {{-5, 5}, {-5, 5}};
		nVec = new NoiseVector(rangesCandD, 0.005);
	}

	PVector getNext() {
		float x = util.flSin(pA * lastPt.y) + pC * util.flCos(pA * lastPt.x);
		float y = util.flSin(pB * lastPt.x) + pD * util.flCos(pB * lastPt.y);
		return new PVector(x, y);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(-5, 5, relMouseXY.x);
		pB = lerp(-5, 5, relMouseXY.y);
		pC = update[0];
		pD = update[1];
		genPts();
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	boolean updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
		}
		return true;
	}
}

// source: http://paulbourke.net/fractals/peterdejong/
class PeterDeJongAttractor extends Attractor {
	float pA = 1.4;
	float pB = -2.3;
	float pC = 2.4;
	float pD = -2.1;
	NoiseVector nVec;

	PeterDeJongAttractor() {
		name = "Peter De Jong";
		lastPt = new PVector(0.1, 0.1);
		magFactor = 200;

		float[][] rangesAandBandCandD = {{-5, 5}, {-5, 5}};
		nVec = new NoiseVector(rangesAandBandCandD, 0.005);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = update[0];
		pB = lerp(-5, 5, relMouseXY.x);
		pC = update[1];
		pD = lerp(-5, 5, relMouseXY.y);
		genPts();
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	PVector getNext() {
		float x = util.flSin(pA * lastPt.y) - util.flCos(pB * lastPt.x);
		float y = util.flSin(pC * lastPt.x) - util.flCos(pD * lastPt.y);
		return new PVector(x, y);
	}

	boolean updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
			case 3: pD += inc; break;
		}
		return true;
	}
}

// source: http://www.3d-meier.de/tut19/Seite70.html
class PickoverAttractor extends Attractor {
	float pA = -0.759;
	float pB = 2.449;
	float pC = 1.253;
	float pD = 1.5;
	NoiseVector nVec;

	PickoverAttractor() {
		name = "Pickover";
		lastPt = new PVector(0, 0, 0);
		magFactor = 350;
		adjY = 250;

		float[][] rangesBandC = {{-3, 3}, {0, 15}};
		nVec = new NoiseVector(rangesBandC, 0.005);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(-5, 5, relMouseXY.x);
		pB = update[0];
		pC = update[1];
		pD = lerp(-5, 5, relMouseXY.y);
		genPts();
	}

	PVector getNext() {
		float x = util.flSin(pA  * lastPt.y) - lastPt.z * util.flCos(pB * lastPt.x);
		float y = lastPt.z * util.flSin(pC * lastPt.x) - util.flCos(pD * lastPt.y);
		float z = util.flSin(lastPt.x);
		return new PVector(x, y, z);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	boolean updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
			case 3: pD += inc; break;
		}
		return true;
	}
}