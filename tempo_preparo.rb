def restos_quocientes(a, b)
  dividendo = a
  divisor = b
  resto = a
  restos = []
  quocientes = []
  while resto != 0
    quociente = (dividendo / divisor).to_i
    quocientes << quociente
    resto = dividendo % divisor
    restos << resto
    dividendo = divisor
    divisor = resto
  end
  restos.unshift(b) if restos.length == 1
  { restos: restos, quocientes: quocientes }
end

def bezout(a, b)
  restos_quocientes = restos_quocientes(a, b)
  s = [1, 0]
  t = [0, 1]
  euc_ext_as = []
  euc_ext_bs = []
  restos_quocientes[:quocientes].each do |q|
    euc_ext_a = s[0] - q * s[1]
    euc_ext_as << euc_ext_a
    euc_ext_b = t[0] - q * t[1]
    euc_ext_bs << euc_ext_b
    s[0] = s[1]
    s[1] = euc_ext_a
    t[0] = t[1]
    t[1] = euc_ext_b
  end
  { gcd: restos_quocientes[:restos][-2], bezout_a: euc_ext_as[-2], bezout_b: euc_ext_bs[-2] }
end


def temp_prep(amp_a, amp_b, miojo)
  bezout_result = bezout(amp_a, amp_b)
  gcd = bezout_result[:gcd]
  if amp_a <= 0 || amp_b <= 0 || miojo <= 0 || miojo >= amp_a || miojo >= amp_b || miojo % gcd != 0
    false
  else
    coeff0 = bezout_result[:bezout_a] * (miojo / gcd).to_i
    coeff1 = bezout_result[:bezout_b] * (miojo / gcd).to_i
    q = coeff0 > 0 ? (coeff0 / amp_b).to_i : (coeff0 / amp_b + 1).to_i

    coeff0 -= q * amp_b
    coeff1 += q * amp_a

    if coeff0 > 0
      coeff2 = coeff0 - amp_b
      coeff3 = coeff1 + amp_a
    else
      coeff2 = coeff0 + amp_b
      coeff3 = coeff1 - amp_a
    end
    max_abs1 = [coeff0.abs, coeff1.abs].max
    max_abs2 = [coeff2.abs, coeff3.abs].max

    new_coeff = max_abs1 > max_abs2 ? { coeff0: coeff2, coeff1: coeff3 } : { coeff0: coeff0, coeff1: coeff1 }
    [amp_a * new_coeff[:coeff0], amp_b * new_coeff[:coeff1]].max
  end
end

