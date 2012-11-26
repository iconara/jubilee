package org.jruby.jubilee;

import org.jruby.Ruby;
import org.jruby.RubyArray;
import org.jruby.runtime.builtin.IRubyObject;

/**
 * Created with IntelliJ IDEA.
 * User: isaiah
 * Date: 11/26/12
 * Time: 11:45 AM
 */
public class Const {
    public static final String DEFAULT_HOST = "localhost";
    public static final int DEFAULT_PORT = 3001;


    public static final String JUBILEE_VERSION = "0.0.1";
    public static final String VERSION = "0.0.1";
    public static final String HTTP_11 = "HTTP/1.1";
    public static final String HTTP_10 = "HTTP/1.0";

    public static final String SERVER_SOFTWARE = "SERVER_SOFTWARE";
    public static final String SERVER_PROTOCOL = "SERVER_PROTOCOL";
    public static final String GATEWAY_INTERFACE = "GATEWAY_INTERFACE";
    public static final String SERVER_NAME = "SERVER_NAME";
    public static final String SERVER_PORT = "SERVER_PORT";

    public static final String CGI_VER = "CGI/1.2";

    public static final String RACK_INPUT = "rack.input";

    public static final String REQUEST_METHOD = "REQUEST_METHOD";
    public static final String GET = "GET";
    public static final String POST = "POST";
    public static final String REQUEST_PATH = "REQUEST_PATH";
    public static final String REQUEST_URI = "REQUEST_URI";
    public static final String PATH_INFO = "PATH_INFO";
    public static final String QUERY_STRING = "QUERY_STRING";

    public static final String HTTP_HOST = "HTTP_HOST";
    public static final String HTTP_USER_AGENT = "HTTP_USER_AGENT";
    public static final String HTTP_ACCEPT = "HTTP_ACCEPT";
    public static final String HTTP_COOKIE = "HTTP_COOKIE";
    public static final String HTTP_ACCEPT_LANGUAGE = "HTTP_ACCEPT_LANGUAGE";
    public static final String HTTP_ACCEPT_ENCODING = "HTTP_ACCEPT_ENCODING";
    public static final String HTTP_CONNECTION = "HTTP_CONNECTION";
    public static final String HTTP_CONTENT_TYPE = "Content-Type";
    public static final String HTTP_CONTENT_LENGTH = "Content-Length";

    public static RubyArray RackVersion(Ruby runtime) {
        RubyArray version = RubyArray.newArray(runtime, 2);
        version.add("1");
        version.add("1");
        return version;
    }
}