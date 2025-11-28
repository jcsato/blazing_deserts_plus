::BDP.Helpers <- {
	beautifyNumber = function(_n) {
		_n = Math.round(_n * 0.1)
		_n = _n * 10.0;
		return _n;
	}
}
