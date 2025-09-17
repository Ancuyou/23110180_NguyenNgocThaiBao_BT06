package org.example.demospringboot.config;

import org.apache.catalina.*;
import org.springframework.util.ResourceUtils;

import java.net.URI;
import java.net.URL;

public class JSPStaticResourceConfigurer implements LifecycleListener {

    private final Context context;

    public JSPStaticResourceConfigurer(Context context) {
        this.context = context;
    }

    private final String subPath = "/META-INF/resources";

    @Override
    public void lifecycleEvent(LifecycleEvent event) {
        // Chỉ xử lý khi Tomcat start
        if (!event.getType().equals(Lifecycle.CONFIGURE_START_EVENT)) {
            return;
        }

        final URL finalLocation = getUrl();

        this.context.getResources().createWebResourceSet(
                WebResourceRoot.ResourceSetType.RESOURCE_JAR,
                "/",            // mount vào root "/"
                finalLocation,
                subPath
        );
    }

    private URL getUrl() {
        final URL location = this.getClass().getProtectionDomain().getCodeSource().getLocation();

        if (ResourceUtils.isFileURL(location)) {
            // Khi chạy trong môi trường dev (IDE)
            return location;
        } else if (ResourceUtils.isJarURL(location)) {
            try {
                // Khi chạy dưới dạng JAR
                String locationStr = location.getPath()
                        .replaceFirst("^nested:", "")
                        .replaceFirst("/!BOOT-INF/classes/!/$", "!/");

                return new URI("jar:file", locationStr, null).toURL();

            } catch (Exception e) {
                throw new IllegalStateException("Unable to add new JSP source URI to tomcat resources", e);
            }
        } else {
            throw new IllegalStateException("Unhandled URL type: " + location);
        }
    }
}

