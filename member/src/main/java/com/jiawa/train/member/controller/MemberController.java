    package com.jiawa.train.member.controller;

    import com.jiawa.train.member.mapper.MemberMapper;
    import jakarta.annotation.Resource;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.RequestMapping;
    import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member")
public class MemberController {
    @Resource
    private MemberMapper memberMapper;

    @GetMapping("/count")
    public Integer count() {
        return memberMapper.count();
    }
}
