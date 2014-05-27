// source: http://paulbourke.net/fractals/clifford/
class CliffordAttractor extends Attractor {
	float pA = -1.4;
	float pB = 1.6;
	float pC = 1;
	float pD = 0.7;
	NoiseVector nVec;

	CliffordAttractor() {
		name = "Clifford";
		magFactor = 150;

		float[][] rangesCandD = {{-5, 5}, {-5, 5}};
		nVec = new NoiseVector(rangesCandD, 0.005);
	}

	PVector getNext() {
		float x = sin(pA * lastPt.y) + pC * cos(pA * lastPt.x);
		float y = sin(pB * lastPt.x) + pD * cos(pB * lastPt.y);
		return new PVector(x, y);
	}

	void reset() {
		lastPt = new PVector(0.1, 0.1);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(-5, 5, relMouseXY.x);
		pB = lerp(-5, 5, relMouseXY.y);
		pC = update[0];
		pD = update[1];
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	void updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
		}
	}
}

// source: http://paulbourke.net/fractals/duffing/
// source: http://www.3d-meier.de/tut5a/Seite41.html
class DuffingAttractor extends Attractor {
	float pA = 0.25;
	float pB = 0.3;
	float pC = 1;
	float sP = 0.01;
	int time;
	NoiseVector nVec;

	DuffingAttractor() {
		name = "Duffing";
		magFactor = 100;
	}

	void reset() {
		time = 0;
		lastPt = new PVector(0.1, 0.1);
	}

	void update() {
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(0, 1, relMouseXY.x);
		pB = lerp(0, 1, relMouseXY.y);
	}

	PVector getNext() {
		float x = lastPt.x + sP * lastPt.y;
		float y = lastPt.y + sP * (lastPt.x - pow(lastPt.x, 3) - pA * lastPt.y + pB * cos(pC * time));
		time += sP;
		return new PVector(x, y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4)};
		return paramsDisp;
	}

	void updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
		}
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
		magFactor = 200;

		float[][] rangesAandBandCandD = {{-5, 5}, {-5, 5}};
		nVec = new NoiseVector(rangesAandBandCandD, 0.005);
	}

	void reset() {
		lastPt = new PVector(0.1, 0.1);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = update[0];
		pB = lerp(-5, 5, relMouseXY.x);
		pC = update[1];
		pD = lerp(-5, 5, relMouseXY.y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	PVector getNext() {
		float x = sin(pA * lastPt.y) - cos(pB * lastPt.x);
		float y = sin(pC * lastPt.x) - cos(pD * lastPt.y);
		return new PVector(x, y);
	}

	void updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
			case 3: pD += inc; break;
		}
	}
}

// source: http://paulbourke.net/fractals/lyapunov/ (see the contribution, at top)
// code: http://paulbourke.net/fractals/lyapunov/attractor.basic
class PhillipHamAttractor extends Attractor {
	float pA = 0;
	float pB = 0;
	float pC = 2;
	NoiseVector nVec;

	PhillipHamAttractor() {
		name = "Phillip Ham";
		magFactor = 200;

		float[][] rangesAandB = {{0, 1}, {0, 1}};
		nVec = new NoiseVector(rangesAandB, 0.005);
	}

	void reset() {
		lastPt = new PVector(1, 1);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = update[0];
		pB = update[1];
		pC = lerp(1, 3, relMouseXY.x);
	}

	PVector getNext() {
		float x = pow(tan(lastPt.x), 2) - pow(sin(lastPt.y), 2) + pA;
		float y = pC * tan(lastPt.x) * sin(lastPt.y) + pB;
		return new PVector(x, y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4)};
		return paramsDisp;
	}

	void updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
		}
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
		magFactor = 350;
		adjY = 250;

		float[][] rangesBandC = {{-3, 3}, {0, 15}};
		nVec = new NoiseVector(rangesBandC, 0.005);
	}

	void reset() {
		lastPt = new PVector(0, 0, 0);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(-5, 5, relMouseXY.x);
		pB = update[0];
		pC = update[1];
		pD = lerp(-5, 5, relMouseXY.y);
	}

	PVector getNext() {
		float x = sin(pA  * lastPt.y) - lastPt.z * cos(pB * lastPt.x);
		float y = lastPt.z * sin(pC * lastPt.x) - cos(pD * lastPt.y);
		float z = sin(lastPt.x);
		return new PVector(x, y, z);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4)};
		return paramsDisp;
	}

	void updateParam(int num, float inc) {
		switch (num) {
			case 0: pA += inc; break;
			case 1: pB += inc; break;
			case 2: pC += inc; break;
			case 3: pD += inc; break;
		}
	}
}