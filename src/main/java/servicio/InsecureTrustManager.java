
package servicio;

import java.security.cert.X509Certificate;
import javax.net.ssl.X509TrustManager;

public class InsecureTrustManager implements X509TrustManager{
    @Override
    public X509Certificate[] getAcceptedIssuers() {
        return new X509Certificate[0];
    }
    @Override
    public void checkClientTrusted(X509Certificate[] certs, String authType) {}
    @Override
    public void checkServerTrusted(X509Certificate[] certs, String authType) {}
}
