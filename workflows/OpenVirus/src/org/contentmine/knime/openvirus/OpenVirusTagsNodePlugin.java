/* @(#)$RCSfile$ 
 * $Revision$ $Date$ $Author$
 *
 */
package org.contentmine.knime.openvirus;

import java.util.List;
import java.util.Set;

import org.eclipse.core.runtime.Plugin;
import org.knime.ext.textprocessing.data.Tag;
import org.osgi.framework.BundleContext;

/**
 * This is the eclipse bundle activator.
 * Note: KNIME node developers probably won't have to do anything in here, 
 * as this class is only needed by the eclipse platform/plugin mechanism.
 * If you want to move/rename this file, make sure to change the plugin.xml
 * file in the project root directory accordingly.
 *
 * @author ContentMine
 */


public class OpenVirusTagsNodePlugin extends Plugin {
    // The shared instance.

	
	
    private static OpenVirusTagsNodePlugin plugin;

    /**
     * The constructor.
     */
    public OpenVirusTagsNodePlugin() {
        super();
        plugin = this;
    }

    /**
     * This method is called upon plug-in activation.
     * 
     * @param context The OSGI bundle context
     * @throws Exception If this plugin could not be started
     */
    @Override
    public void start(final BundleContext context) throws Exception {
        super.start(context);

    }

    /**
     * This method is called when the plug-in is stopped.
     * 
     * @param context The OSGI bundle context
     * @throws Exception If this plugin could not be stopped
     */
    @Override
    public void stop(final BundleContext context) throws Exception {
        super.stop(context);
        plugin = null;
    }

    /**
     * Returns the shared instance.
     * 
     * @return Singleton instance of the Plugin
     */
    public static OpenVirusTagsNodePlugin getDefault() {
        return plugin;
    }

	

}

