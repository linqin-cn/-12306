    package com.jiawa.train.member.controller;

    import com.jiawa.train.common.resp.CommonResp;
    import com.jiawa.train.member.mapper.MemberMapper;
    import com.jiawa.train.member.req.MemberLoginReq;
    import com.jiawa.train.member.req.MemberRegisterReq;
    import com.jiawa.train.member.req.MemberSendCodeReq;
    import com.jiawa.train.member.resp.MemberLoginResp;
    import com.jiawa.train.member.service.MemberService;
    import jakarta.annotation.Resource;
    import jakarta.validation.Valid;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.web.bind.annotation.*;

    @RestController
@RequestMapping("/member")
public class MemberController {
    @Resource
    private MemberMapper memberMapper;
    @Autowired
    private MemberService memberService;

    @GetMapping("/count")
    public CommonResp<Integer> count() {
        int count = memberService.count();
        CommonResp<Integer> commonResp = new CommonResp();
        commonResp.setContent(count);
        return commonResp;
    }

    @PostMapping("/register")
    public CommonResp<Long> register(@Valid MemberRegisterReq req) {
        long  register = memberService.register(req);
        CommonResp<Long> commonResp = new CommonResp();
        commonResp.setContent(register);
        return commonResp;
    }

    @PostMapping("/send-code")
    public CommonResp<Long> sendCode(@Valid @RequestBody MemberSendCodeReq req) {
        memberService.sendCode(req);
        return new CommonResp<>();
    }

    @PostMapping("/login")
    public CommonResp<MemberLoginResp> login(@Valid @RequestBody MemberLoginReq req) {
        MemberLoginResp login = memberService.login(req);
        return new CommonResp<>(login);
    }
}





















