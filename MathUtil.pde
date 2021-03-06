class MathUtil {
	// utils
	void calcVecMax(PVector store, PVector pt) {
		store.x = Math.max(store.x, pt.x);
		store.y = Math.max(store.y, pt.y);
		store.z = Math.max(store.z, pt.z);
	}

	void calcVecMin(PVector store, PVector pt) {
		store.x = Math.min(store.x, pt.x);
		store.y = Math.min(store.y, pt.y);
		store.z = Math.min(store.z, pt.z);
	}

	float roundTo(float n, int places) {
		return round(n * pow(10, places)) / pow(10, places);
	}

	float noiseIndex = random(20);

	float noiseRandom(float min, float max) {
		noiseIndex += 0.1;
		return min + (noise(noiseIndex) * (max - min));
	}

	PVector getRelMouseXY() {
		return new PVector((float) mouseX / (float) width, (float) mouseY / (float) height);
	}

	color colorScale0 = color(0, 100, 100);
	color colorScale1 = color(270, 100, 100);

	color getColorFromDist(float dist, float max) {
		return lerpColor(colorScale0, colorScale1, 1 - (dist / max));
	}
}

class NoiseVector {
	float inc;
	float[][] ranges;
	float[] indexes;

	NoiseVector(float[][] cRanges, float cInc) {
		inc = cInc;
		ranges = cRanges;
		indexes = new float[ranges.length];
		for (int i = 0, len = ranges.length; i < len; ++i) {
			indexes[i] = random(20);
		}
	}

	float[] getNext() {
		float[] values = new float[ranges.length];
		for (int i = 0, len = ranges.length; i < len; ++i) {
			indexes[i] += inc;
			values[i] = valFromRng(indexes[i], ranges[i]);
		}
		return values;
	}

	float valFromRng(float ind, float[] rng) {
		return rng[0] + noise(ind) * (rng[1] - rng[0]);
	}
}
