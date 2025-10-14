package entidad;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaccion {
    private String codTransaccion;
    private String numCuentaOrigen;
    private String numCuentaDestino;
    private String codTipMovimiento;
    private Timestamp fec;
    private BigDecimal monto;
    private String canal;
    private String codEstado;

    public Transaccion() {
    }
    
    public String getCodTransaccion() { 
        return codTransaccion; 
    }
    
    public void setCodTransaccion(String codTransaccion) { 
        this.codTransaccion = codTransaccion; 
    }

    public String getNumCuentaOrigen() { 
        return numCuentaOrigen; 
    }
    
    public void setNumCuentaOrigen(String numCuentaOrigen) { 
        this.numCuentaOrigen = numCuentaOrigen; 
    }

    public String getNumCuentaDestino() { 
        return numCuentaDestino; 
    }
    
    public void setNumCuentaDestino(String numCuentaDestino) { 
        this.numCuentaDestino = numCuentaDestino; 
    }

    public String getCodTipMovimiento() { 
        return codTipMovimiento; 
    }
    
    public void setCodTipMovimiento(String codTipMovimiento) { 
        this.codTipMovimiento = codTipMovimiento; 
    }

    public Timestamp getFec() { 
        return fec; 
    }
    
    public void setFec(Timestamp fec) { 
        this.fec = fec; 
    }

    public BigDecimal getMonto() { 
        return monto; 
    }
    
    public void setMonto(BigDecimal monto) { 
        this.monto = monto; 
    }

    public String getCanal() { 
        return canal; 
    }
    
    public void setCanal(String canal) { 
        this.canal = canal; 
    }

    public String getCodEstado() { 
        return codEstado; 
    }
    
    public void setCodEstado(String codEstado) { 
        this.codEstado = codEstado; 
    }
}
