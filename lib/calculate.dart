import 'dart:math';

class Calculate {
  int finalData;

  Calculate({required this.finalData});

  String calculateScore() {
    return finalData.toString();
  }

  String getResult() {
    if (finalData==0) {
      return 'Sin Riesgo';
    }
    else if (finalData >= 1 && finalData <= 11) {
      return 'Leve';
    } else if (finalData >= 12 && finalData <= 22) {
      return 'Moderado';
    } else {
      return 'Alto';
    }
  }

  String getIndications() {
    if (finalData==0) {
      return '- Cumplir medidas de prevención.\n- Para personas con factores de alto riesgo*, mantener seguimiento frecuente con telemedicina.';
    }
   else if (finalData >= 1 && finalData <= 11) {
      return '- Manejo domiciliario.\n- Considerar hospitalización si existe (hipoxemia, trastornos del sensorio, taquipnea o inestabilidad hemodinámica).';
    } else if (finalData >= 12 && finalData <= 22) {
      return '- Hospitalización en Unidad de Cuidados Intermedios (UTI).\n- Considerar uso de sistema de alto flujo de oxígeno (Sistema Venturi o Ventimask) y de ventilación mecánica no invasiva (CPAP o BIPAP).';
    } else {
      return '- Hospitalizar en Unidad de Cuidados Intensivos (UCI).\n- Considerar soporte ventilatorio invasivo (VMI)';
    }
  }

}
