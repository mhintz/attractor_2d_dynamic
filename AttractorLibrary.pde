// source: http://alteredqualia.com/attractor
class AlteredQualiaAttractor extends Attractor {
	float pA;
	float pB;
	float pC;
	float pD;
	float pE;
	float pF;
	float pG;
	float pH;
	NoiseVector nVec;

	AlteredQualiaAttractor() {
		name = "Altered Qualia";
		magFactor = 120;

		float[][] ranges = {
			{-2, 2},
			{-2, 2},
			{-2, 2},
			{0.1, 2},
			{-2, 2},
			{-2, 2},
			{-2, 2},
			{0.1, 2}
		};
		nVec = new NoiseVector(ranges, 0.3);
	}

	void update() {
		PVector relMouseXY = util.getRelMouseXY();

		float[] update = nVec.getNext();
		pA = random(-2, 2);  //update[0];
		pB = random(-2, 2);  //update[1];
		pC = random(-2, 2);  //update[2];
		pD = random(0.1, 2); //update[3];
		pE = random(-2, 2);  //update[4];
		pF = random(-2, 2);  //update[5];
		pG = random(-2, 2);  //update[6];
		pH = random(0.1, 2); //update[7];
	}

	void reset() {
		lastPt = new PVector(0, 0);
	}

	PVector getNext() {
		float x = pA * sin(pB * lastPt.y) + pC * cos(pD * lastPt.x);
		float y = pE * sin(pF * lastPt.x) + pG * cos(pH * lastPt.y);
		return new PVector(x, y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4), "C: "+util.roundTo(pC, 4), "D: "+util.roundTo(pD, 4), "E: "+util.roundTo(pE, 4), "F: "+util.roundTo(pF, 4), "G: "+util.roundTo(pG, 4), "H: "+util.roundTo(pH, 4)};
		return paramsDisp;
	}
}


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

// source: http://www.3d-meier.de/tut5/Seite9.html
class HenonAttractor extends Attractor {
	float pA = 1.4;
	float pB = 0.3;

	HenonAttractor() {
		name = "Henon";
		magFactor = 100;
	}

	void reset() {
		lastPt = new PVector(0, 0);
	}

	void update() {
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(1, 1.6, relMouseXY.x);
		pB = lerp(0, 0.6, relMouseXY.y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4)};
		return paramsDisp;
	}

	PVector getNext() {
		float x = 1 + lastPt.y - pA * pow(lastPt.x, 2);
		float y = pB * lastPt.x;
		return new PVector(x, y);
	}
}

class KingsDreamAttractor extends Attractor {
	float pA = 1.4;
	float pB = 1.4;
	float pC = 1.4;
	float pD = 1.4;
	NoiseVector nVec;

	KingsDreamAttractor() {
		name = "King's Dream";
		magFactor = 150;

		float[][] rangesABCD = {{-0.5, 1.5}, {-0.5, 1.5}};
		nVec = new NoiseVector(rangesABCD, 0.005);
	}

	void reset() {
		lastPt = new PVector(0.1, 0.1);
	}

	void update() {
		float[] update = nVec.getNext();
		PVector relMouseXY = util.getRelMouseXY();
		pA = lerp(-3, 3, relMouseXY.x);
		pB = update[0];
		pC = lerp(-3, 3, relMouseXY.y);
		pD = update[1];
	}

	PVector getNext() {
		float x = sin(pA * lastPt.y) + pB * sin(pA * lastPt.x);
		float y = sin(pC * lastPt.x) + pD * sin(pC * lastPt.y);
		return new PVector(x, y);
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

// source: http://www.3d-meier.de/tut5/Seite25.html
class TinkerbellAttractor extends Attractor {
	float pA = 0.9;
	float pB = 0.6013;
	float sP = 1;

	TinkerbellAttractor() {
		name = "Tinkerbell";
		magFactor = 300;
	}

	void reset() {
		lastPt = new PVector(0.01, 0.01);
	}

	void update() {
		PVector relMouseXY = util.getRelMouseXY();
		pB = lerp(0.2, 0.7, relMouseXY.x);
		pA = lerp(0.6, 1.2, relMouseXY.y);
	}

	PVector getNext() {
		float x = sP * pow(lastPt.x, 2) - pow(lastPt.y, 2) + pA * lastPt.x + pB * lastPt.y;
		float y = sP * 2 * lastPt.x * lastPt.y - 2 * lastPt.x + 0.5 * lastPt.y;
		return new PVector(x, y);
	}

	String[] getParamsDisplay() {
		String[] paramsDisp = {"A: "+util.roundTo(pA, 4), "B: "+util.roundTo(pB, 4)};
		return paramsDisp;
	}
}