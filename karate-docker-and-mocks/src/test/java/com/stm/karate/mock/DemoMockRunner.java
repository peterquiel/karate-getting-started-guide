package com.stm.karate.mock;

import com.intuit.karate.junit5.Karate;

public class DemoMockRunner {

    @Karate.Test
    Karate testDemoMockServer() {
        return Karate.run("demo-mock-test").relativeTo(getClass());
    }

}
