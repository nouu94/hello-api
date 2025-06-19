package com.example.demo;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


// Rest API 요청을 처리하는 컨트롤러임을 나타냄
@RestController
public class HelloController {

    // http get 요청에 대응할 메서드를 지정
    @GetMapping("/hello")
    public Map<String, String> hello() {

        // 응답으로 key:value 형태의 json 객체를 반환하기 위해 사용
        return Map.of("hello", "world");
    }
}
