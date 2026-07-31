--[[OBFDATA:eyJuYW1lcyI6IHt9LCAic2V0dGluZ3MiOiB7InJlbmFtZV92YXJzIjogdHJ1ZSwgImVuY29kZV9zdHJpbmdzIjogdHJ1ZSwgInN0cmlwX2NvbW1lbnRzIjogdHJ1ZSwgIm1pbmlmeSI6IHRydWV9fQ==]]
--OBF_DEC_START
local function OBF_DEC(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end
--OBF_DEC_END
#!/usr/bin/env python3
OBF_DEC("")OBF_DEC("Ckx1YSBPYmZ1c2NhdG9yL0Rlb2JmdXNjYXRvciAtIGEtc2hlbGwgbXVsdGktdG9vbAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CjEpIE9iZnVzY2F0ZSAgIC0+IHBhc3RlIEx1YSBzY3JpcHQsIHBpY2sgc2V0dGluZ3MsIGdldCBvYmZ1c2NhdGVkIHNjcmlwdAogICAgICAgICAgICAgICAgICAoYXV0by1jb3BpZWQgdG8gY2xpcGJvYXJkIHdoZW4gZG9uZSkKMikgRGVvYmZ1c2NhdGUgLT4gcGFzdGUgYSBzY3JpcHQgcHJvZHVjZWQgYnkgdGhpcyB0b29sJ3MgT2JmdXNjYXRlIG1vZGUsCiAgICAgICAgICAgICAgICAgIGdldCB0aGUgb3JpZ2luYWwgYmFjayAoYXV0by1jb3BpZWQgdG8gY2xpcGJvYXJkKQozKSBFeGl0CgpOT1RFUyAvIExJTUlUQVRJT05TIChyZWFkIG9uY2UsIGl0IG1hdHRlcnMpOgotIFZhcmlhYmxlIHJlbmFtaW5nIGFuZCBjb21tZW50IHN0cmlwcGluZyBhcmUgZG9uZSB3aXRoIHJlZ2V4IGhldXJpc3RpY3MsCiAgbm90IGEgcmVhbCBMdWEgcGFyc2VyLiBXb3JrcyB3ZWxsIG9uIHR5cGljYWwsIA==")normalOBF_DEC("IEx1YSBzY3JpcHRzLgogIFZlcnkgdW51c3VhbCBzeW50YXggKG5lc3RlZCBsb25nIHN0cmluZ3MvY29tbWVudHMgYFtbIF1dYCwgaGVhdmlseQogIG1peGVkIHF1b3RlIGVzY2FwaW5nLCBldGMuKSBtYXkgbm90IHJvdW5kLXRyaXAgcGVyZmVjdGx5LgotIFJldmVyc2liaWxpdHkgb25seSB3b3JrcyBvbiBzY3JpcHRzIFRISVMgdG9vbCBwcm9kdWNlZDogYSBzbWFsbCBtZXRhZGF0YQogIGJsb2NrICh2YXJpYWJsZSBuYW1lIG1hcCkgaXMgZW1iZWRkZWQgaW4gYSBjb21tZW50IGF0IHRoZSB0b3Agb2YgdGhlCiAgb2JmdXNjYXRlZCBvdXRwdXQgc28g")DeobfuscateOBF_DEC("IGNhbiByZXN0b3JlIG9yaWdpbmFsIG5hbWVzLiBUaGlzIGlzCiAgbm90IG1lYW50IHRvIGRlZmVhdCBhIGRldGVybWluZWQgaHVtYW4gcmVhZGVyIG9mIHRoZSBzb3VyY2UsIG9ubHkgdG8KICBtYWtlIGNhc3VhbCByZWFkaW5nL2NvcHlpbmcgaGFyZGVyIGFuZCB0byBtYWtlIHRoZSBwcm9jZXNzIHJldmVyc2libGUKICBieSB5b3UuCg==")OBF_DEC("")
import re
import sys
import json
import random
import string
import base64
import subprocess
#
# Clipboard helpers (a-shell exposes pbcopy / pbpaste like macOS)
#
def clipboard_paste():
    try:
        result = subprocess.run([OBF_DEC("cGJwYXN0ZQ==")], capture_output=True, text=True, timeout=2)
        if result.returncode == 0:
            return result.stdout
    except Exception:
        pass
    return None
def clipboard_copy(text):
    try:
        subprocess.run([OBF_DEC("cGJjb3B5")], input=text, text=True, timeout=2)
        return True
    except Exception:
        return False
def read_script(label):
    print(fOBF_DEC("XG4tLS0ge2xhYmVsfSAtLS0="))
    clip = clipboard_paste()
    if clip and clip.strip():
        print(OBF_DEC("Q2xpcGJvYXJkIGhhcyBjb250ZW50LiBVc2UgY2xpcGJvYXJkIGNvbnRlbnQ/ICh5L24p"))
        if input(OBF_DEC("PiA=")).strip().lower().startswith(OBF_DEC("eQ==")):
            return clip
    print(OBF_DEC("UGFzdGUgeW91ciBzY3JpcHQgYmVsb3cuIE9uIGl0cyBvd24gbGluZSwgdHlwZSBFTkQgd2hlbiBmaW5pc2hlZDo="))
    lines = []
    while True:
        try:
            line = input()
        except EOFError:
            break
        if line.strip() == OBF_DEC("RU5E"):
            break
        lines.append(line)
    return OBF_DEC("XG4=").join(lines)
def finish_with_output(text, action_name):
    print(fOBF_DEC("XG4tLS0ge2FjdGlvbl9uYW1lfSByZXN1bHQgLS0tXG4="))
    print(text)
    if clipboard_copy(text):
        print(fOBF_DEC("XG5bQ29waWVkIHRvIGNsaXBib2FyZF0="))
    else:
        print(OBF_DEC("XG5bQ291bGQgbm90IGFjY2VzcyBjbGlwYm9hcmQgYXV0b21hdGljYWxseSAtIGNvcHkgdGhlIHRleHQgYWJvdmUgbWFudWFsbHld"))
#
# Lua language knowledge
#
LUA_KEYWORDS = {
    OBF_DEC("YW5k"), OBF_DEC("YnJlYWs="), OBF_DEC("ZG8="), OBF_DEC("ZWxzZQ=="), OBF_DEC("ZWxzZWlm"), OBF_DEC("ZW5k"), OBF_DEC("ZmFsc2U="), OBF_DEC("Zm9y"), OBF_DEC("ZnVuY3Rpb24="),
    OBF_DEC("Z290bw=="), OBF_DEC("aWY="), OBF_DEC("aW4="), OBF_DEC("bG9jYWw="), OBF_DEC("bmls"), OBF_DEC("bm90"), OBF_DEC("b3I="), OBF_DEC("cmVwZWF0"), OBF_DEC("cmV0dXJu"),
    OBF_DEC("dGhlbg=="), OBF_DEC("dHJ1ZQ=="), OBF_DEC("dW50aWw="), OBF_DEC("d2hpbGU="),
}
LUA_COMMON_GLOBALS = {
    OBF_DEC("cHJpbnQ="), OBF_DEC("cGFpcnM="), OBF_DEC("aXBhaXJz"), OBF_DEC("bmV4dA=="), OBF_DEC("dHlwZQ=="), OBF_DEC("dG9zdHJpbmc="), OBF_DEC("dG9udW1iZXI="),
    OBF_DEC("dGFibGU="), OBF_DEC("c3RyaW5n"), OBF_DEC("bWF0aA=="), OBF_DEC("b3M="), OBF_DEC("aW8="), OBF_DEC("cmVxdWlyZQ=="), OBF_DEC("cGNhbGw="), OBF_DEC("eHBjYWxs"),
    OBF_DEC("ZXJyb3I="), OBF_DEC("YXNzZXJ0"), OBF_DEC("c2VsZWN0"), OBF_DEC("dW5wYWNr"), OBF_DEC("c2V0bWV0YXRhYmxl"), OBF_DEC("Z2V0bWV0YXRhYmxl"),
    OBF_DEC("cmF3Z2V0"), OBF_DEC("cmF3c2V0"), OBF_DEC("cmF3ZXF1YWw="), OBF_DEC("c2VsZg=="), OBF_DEC("Z2FtZQ=="), OBF_DEC("d29ya3NwYWNl"), OBF_DEC("c2NyaXB0"),
    OBF_DEC("d2FpdA=="), OBF_DEC("c3Bhd24="), OBF_DEC("ZGVsYXk="), OBF_DEC("SW5zdGFuY2U="), OBF_DEC("VmVjdG9yMw=="), OBF_DEC("Q0ZyYW1l"), OBF_DEC("Q29sb3Iz"),
    OBF_DEC("dGFzaw=="), OBF_DEC("Y29yb3V0aW5l"),
}
MARKER_START = OBF_DEC("LS1PQkZfREVDX1NUQVJU")
MARKER_END = OBF_DEC("LS1PQkZfREVDX0VORA==")
META_RE = re.compile(rOBF_DEC("LS1cW1xbT0JGREFUQTooW0EtWmEtejAtOSsvPV0rKVxdXF1cbj8="))
STRING_RE = re.compile(rOBF_DEC("Iig/OlteIlxcXXxcXC4pKiJ8XCcoPzpbXlwnXFxdfFxcLikqXCc="))
LOCAL_DECL_RE = re.compile(rOBF_DEC("XGJsb2NhbFxzKygoPzpbQS1aYS16X11cdypccyosXHMqKSpbQS1aYS16X11cdyop"))
FUNC_PARAMS_RE = re.compile(rOBF_DEC("ZnVuY3Rpb25ccypbXHdcLjpdKlxzKlwoKFteKV0qKVwp"))
FUNC_NAMED_RE = re.compile(rOBF_DEC("XGJsb2NhbFxzK2Z1bmN0aW9uXHMrKFtBLVphLXpfXVx3Kik="))
def random_name(length=8):
    first = random.choice(string.ascii_letters + OBF_DEC("Xw=="))
    rest = OBF_DEC("").join(random.choice(string.ascii_letters + string.digits + OBF_DEC("Xw==")) for _ in range(length - 1))
    return first + rest
def escape_lua_string(s):
    out = s.replace(OBF_DEC("XFw="), OBF_DEC("XFxcXA==")).replace(OBF_DEC("Ig=="), OBF_DEC("XFwi")).replace(OBF_DEC("XG4="), OBF_DEC("XFxu")).replace(OBF_DEC("XHI="), OBF_DEC("XFxy"))
    return fOBF_DEC("IntvdXR9Ig==")
#
# Settings menu
#
def yn(prompt, default=True):
    d = OBF_DEC("WS9u") if default else OBF_DEC("eS9O")
    ans = input(fOBF_DEC("e3Byb21wdH0gW3tkfV06IA==")).strip().lower()
    if not ans:
        return default
    return ans.startswith(OBF_DEC("eQ=="))
def select_settings():
    print(OBF_DEC("XG4tLS0gT2JmdXNjYXRpb24gc2V0dGluZ3MgLS0t"))
    settings = {
        OBF_DEC("cmVuYW1lX3ZhcnM="): yn(OBF_DEC("UmVuYW1lIGxvY2FsIHZhcmlhYmxlcyAvIGZ1bmN0aW9uIG5hbWVzPw=="), True),
        OBF_DEC("ZW5jb2RlX3N0cmluZ3M="): yn(OBF_DEC("RW5jb2RlIHN0cmluZyBsaXRlcmFscyAoYmFzZTY0ICsgZGVjb2Rlcik/"), True),
        OBF_DEC("c3RyaXBfY29tbWVudHM="): yn(OBF_DEC("U3RyaXAgY29tbWVudHM/"), True),
        OBF_DEC("bWluaWZ5"): yn(OBF_DEC("Q29sbGFwc2UgYmxhbmsgbGluZXMgLyBleHRyYSB3aGl0ZXNwYWNlPw=="), True),
    }
    return settings
#
# Obfuscation
#
def extract_strings(code):
    strings = []
    def repl(m):
        strings.append(m.group(0))
        return fOBF_DEC("QEBTVFJ7bGVuKHN0cmluZ3MpLTF9QEA=")
    return STRING_RE.sub(repl, code), strings
def strip_comments(code):
    # block comments   (non-greedy, no nesting support)
    code = re.sub(rOBF_DEC("LS1cW1xbLio/XF1cXQ=="), OBF_DEC(""), code, flags=re.DOTALL)
    # line comments
    code = re.sub(rOBF_DEC("LS1bXlxuXSo="), OBF_DEC(""), code)
    return code
def build_rename_map(code):
    candidates = set()
    for m in LOCAL_DECL_RE.finditer(code):
        for name in m.group(1).split(OBF_DEC("LA==")):
            candidates.add(name.strip())
    for m in FUNC_PARAMS_RE.finditer(code):
        for name in m.group(1).split(OBF_DEC("LA==")):
            name = name.strip()
            if name and name != OBF_DEC("Li4u"):
                candidates.add(name)
    for m in FUNC_NAMED_RE.finditer(code):
        candidates.add(m.group(1))
    candidates -= LUA_KEYWORDS
    candidates -= LUA_COMMON_GLOBALS
    candidates.discard(OBF_DEC(""))
    used = set()
    mapping = {}
    for name in candidates:
        new = random_name()
        while new in used:
            new = random_name()
        used.add(new)
        mapping[name] = new
    return mapping
def apply_rename(code, mapping):
    for old, new in mapping.items():
        code = re.sub(rOBF_DEC("XGI=") + re.escape(old) + rOBF_DEC("XGI="), new, code)
    return code
def minify(code):
    lines = [ln.rstrip() for ln in code.split(OBF_DEC("XG4="))]
    lines = [ln for ln in lines if ln.strip() != OBF_DEC("")]
    return OBF_DEC("XG4=").join(lines)
LUA_B64_DECODER = fOBF_DEC("")OBF_DEC("e01BUktFUl9TVEFSVH0KbG9jYWwgZnVuY3Rpb24gT0JGX0RFQyhkYXRhKQogICAgbG9jYWwgYj0nQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjM0NTY3ODkrLz0nCiAgICBkYXRhID0gc3RyaW5nLmdzdWIoZGF0YSwgJ1teJy4uYi4uJz1dJywgJycpCiAgICByZXR1cm4gKGRhdGE6Z3N1YignLicsIGZ1bmN0aW9uKHgpCiAgICAgICAgaWYgKHggPT0gJz0nKSB0aGVuIHJldHVybiAnJyBlbmQKICAgICAgICBsb2NhbCByLGY9JycsKGI6ZmluZCh4KS0xKQogICAgICAgIGZvciBpPTYsMSwtMSBkbyByPXIuLihmJTJeaS1mJTJeKGktMSk+MCBhbmQgJzEnIG9yICcwJykgZW5kCiAgICAgICAgcmV0dXJuIHI7CiAgICBlbmQpOmdzdWIoJyVkJWQlZD8lZD8lZD8lZD8lZD8lZD8nLCBmdW5jdGlvbih4KQogICAgICAgIGlmICgjeCB+PSA4KSB0aGVuIHJldHVybiAnJyBlbmQKICAgICAgICBsb2NhbCBjPTAKICAgICAgICBmb3IgaT0xLDggZG8gYz1jKyh4OnN1YihpLGkpPT0nMScgYW5kIDJeKDgtaSkgb3IgMCkgZW5kCiAgICAgICAgcmV0dXJuIHN0cmluZy5jaGFyKGMpCiAgICBlbmQpKQplbmQKe01BUktFUl9FTkR9Cg==")OBF_DEC("")
def obfuscate(code, settings):
    code, strings = extract_strings(code)
    if settings[OBF_DEC("c3RyaXBfY29tbWVudHM=")]:
        code = strip_comments(code)
    mapping = {}
    if settings[OBF_DEC("cmVuYW1lX3ZhcnM=")]:
        mapping = build_rename_map(code)
        code = apply_rename(code, mapping)
    if settings[OBF_DEC("bWluaWZ5")]:
        code = minify(code)
    # reinsert strings, optionally encoded
    def restore(m):
        idx = int(m.group(1))
        literal = strings[idx]
        if settings[OBF_DEC("ZW5jb2RlX3N0cmluZ3M=")]:
            inner = literal[1:-1]
            # decode escape sequences minimally then re-encode raw bytes
            raw = inner.encode(OBF_DEC("dXRmLTg=")).decode(OBF_DEC("dW5pY29kZV9lc2NhcGU=")).encode(OBF_DEC("bGF0aW4tMQ=="), errors=OBF_DEC("aWdub3Jl"))
            try:
                raw = inner.encode(OBF_DEC("dXRmLTg="))
            except Exception:
                pass
            b64 = base64.b64encode(inner.encode(OBF_DEC("dXRmLTg="))).decode()
            return fOBF_DEC("T0JGX0RFQygie2I2NH0iKQ==")
        return literal
    code = re.sub(rOBF_DEC("QEBTVFIoXGQrKUBA"), restore, code)
    header = OBF_DEC("")
    if settings[OBF_DEC("ZW5jb2RlX3N0cmluZ3M=")]:
        header += LUA_B64_DECODER
    meta = {OBF_DEC("bmFtZXM="): {v: k for k, v in mapping.items()}, OBF_DEC("c2V0dGluZ3M="): settings}
    meta_b64 = base64.b64encode(json.dumps(meta).encode()).decode()
    header = fOBF_DEC("LS1bW09CRkRBVEE6e21ldGFfYjY0fV1dXG4=") + header
    return header + code
#
# Deobfuscation
#
def deobfuscate(code):
    m = META_RE.search(code)
    if not m:
        print(OBF_DEC("XG5bIV0gTm8gZW1iZWRkZWQgbWV0YWRhdGEgZm91bmQuIFRoaXMgc2NyaXB0IG1heSBub3QgaGF2ZSBiZWVu"))
        print(OBF_DEC("ICAgIHByb2R1Y2VkIGJ5IHRoaXMgdG9vbCdzIE9iZnVzY2F0ZSBtb2RlIC0gY2Fubm90IGZ1bGx5IHJldmVyc2UgaXQu"))
        return code
    meta = json.loads(base64.b64decode(m.group(1)).decode())
    code = META_RE.sub(OBF_DEC(""), code, count=1)
    # remove injected decoder block if present
    code = re.sub(
        re.escape(MARKER_START) + rOBF_DEC("Lio/") + re.escape(MARKER_END) + rOBF_DEC("XG4/"),
        OBF_DEC(""),
        code,
        flags=re.DOTALL,
    )
    # decode OBF_DEC(OBF_DEC("Li4u")) calls back to literals
    def decode_call(mm):
        b64 = mm.group(1)
        try:
            original = base64.b64decode(b64).decode(OBF_DEC("dXRmLTg="))
        except Exception:
            original = OBF_DEC("")
        return escape_lua_string(original)
    code = re.sub(rOBF_DEC("T0JGX0RFQ1woIihbQS1aYS16MC05Ky89XSspIlwp"), decode_call, code)
    # restore original variable names (map is new->old)
    names = meta.get(OBF_DEC("bmFtZXM="), {})
    for new, old in names.items():
        code = re.sub(rOBF_DEC("XGI=") + re.escape(new) + rOBF_DEC("XGI="), old, code)
    return code.strip() + OBF_DEC("XG4=")
#
# Main menu
#
def main():
    while True:
        print(OBF_DEC("XG49PT09PSBMdWEgT2JmdXNjYXRvciBUb29sID09PT09"))
        print(OBF_DEC("MSkgT2JmdXNjYXRl"))
        print(OBF_DEC("MikgRGVvYmZ1c2NhdGU="))
        print(OBF_DEC("MykgRXhpdA=="))
        choice = input(OBF_DEC("PiA=")).strip()
        if choice == OBF_DEC("MQ=="):
            script = read_script(OBF_DEC("UGFzdGUgc2NyaXB0IHRvIG9iZnVzY2F0ZQ=="))
            if not script.strip():
                print(OBF_DEC("Tm8gc2NyaXB0IHByb3ZpZGVkLg=="))
                continue
            settings = select_settings()
            result = obfuscate(script, settings)
            finish_with_output(result, OBF_DEC("T2JmdXNjYXRl"))
        elif choice == OBF_DEC("Mg=="):
            script = read_script(OBF_DEC("UGFzdGUgb2JmdXNjYXRlZCBzY3JpcHQ="))
            if not script.strip():
                print(OBF_DEC("Tm8gc2NyaXB0IHByb3ZpZGVkLg=="))
                continue
            result = deobfuscate(script)
            finish_with_output(result, OBF_DEC("RGVvYmZ1c2NhdGU="))
        elif choice == OBF_DEC("Mw=="):
            print(OBF_DEC("QnllLg=="))
            sys.exit(0)
        else:
            print(OBF_DEC("SW52YWxpZCBjaG9pY2UsIHBpY2sgMSwgMiBvciAzLg=="))
if __name__ == OBF_DEC("X19tYWluX18="):
    main()
