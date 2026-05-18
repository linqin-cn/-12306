package com.jiawa.train.member.req;

import jakarta.validation.constraints.NotBlank;

public class MemberRegisterReq {
    @Override
    public String toString() {
        return "MemberRegisterReq{" +
                "mobile='" + mobile + '\'' +
                '}';
    }

    @NotBlank(message = "【手机不能为空】")
    private String mobile;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
}
