/*
 PIE: CSS3 rendering for IE
 Version 1.0beta3
 http://css3pie.com
 Dual-licensed for use under the Apache License Version 2.0 or the General Public License (GPL) Version 2.
 */
(function () {
    var doc = document;
    var h = window.PIE;
    if (!h) {
        h = window.PIE = {I:"-pie-", Na:"Pie", Ja:"pie_", Bb:{TD:1, TH:1}};
        try {
            doc.execCommand("BackgroundImageCache", false, true)
        } catch (J) {
        }
        h.D = function () {
            for (var a = 4, b = doc.createElement("div"), c = b.getElementsByTagName("i"); b.innerHTML = "<!--[if gt IE " + ++a + "]><i></i><![endif]--\>", c[0];);
            return a
        }();
        if (h.D === 6)h.I = h.I.replace(/^-/, "");
        h.Wa = h.D === 8 && doc.documentMode;
        h.n = {Aa:function (a) {
            var b = h.ec;
            if (!b) {
                b = h.ec = doc.createDocumentFragment();
                b.namespaces.add("css3vml", "urn:schemas-microsoft-com:vml")
            }
            return b.createElement("css3vml:" + a)
        },
            oa:function (a) {
                return a && a._pieId || (a._pieId = +new Date + Math.random())
            }, $a:function (a) {
                var b, c, g, e, d = arguments;
                b = 1;
                for (c = d.length; b < c; b++) {
                    e = d[b];
                    for (g in e)if (e.hasOwnProperty(g))a[g] = e[g]
                }
                return a
            }, Hb:function (a, b, c) {
                var g = h.Yb || (h.Yb = {}), e = g[a], d;
                if (e)b.call(c, e); else {
                    d = new Image;
                    d.onload = function () {
                        e = g[a] = {g:d.width, e:d.height};
                        b.call(c, e);
                        d.onload = null
                    };
                    d.src = a
                }
            }};
        h.ea = function () {
            this.ab = [];
            this.vb = {}
        };
        h.ea.prototype = {W:function (a) {
            var b = h.n.oa(a), c = this.vb, g = this.ab;
            if (!(b in c)) {
                c[b] = g.length;
                g.push(a)
            }
        }, Ga:function (a) {
            a = h.n.oa(a);
            var b = this.vb;
            if (a && a in b) {
                delete this.ab[b[a]];
                delete b[a]
            }
        }, Ca:function () {
            for (var a = this.ab, b = a.length; b--;)a[b] && a[b]()
        }};
        if (h.Wa === 8) {
            h.La = new h.ea;
            setInterval(function () {
                h.La.Ca()
            }, 250)
        }
        h.F = new h.ea;
        window.attachEvent("onbeforeunload", function () {
            h.F.Ca()
        });
        h.F.ya = function (a, b, c) {
            a.attachEvent(b, c);
            this.W(function () {
                a.detachEvent(b, c)
            })
        };
        (function () {
            function a() {
                h.ta.Ca()
            }

            h.ta = new h.ea;
            h.F.ya(window, "onresize", a)
        })();
        (function () {
            function a() {
                h.Ma.Ca()
            }

            h.Ma =
                new h.ea;
            h.F.ya(window, "onscroll", a);
            h.ta.W(a)
        })();
        (function () {
            function a() {
                c = h.Ka.rc()
            }

            function b() {
                if (c) {
                    for (var g = 0, e = c.length; g < e; g++)h.attach(c[g]);
                    c = 0
                }
            }

            var c;
            h.F.ya(window, "onbeforeprint", a);
            h.F.ya(window, "onafterprint", b)
        })();
        h.i = function () {
            function a(d) {
                this.w = d
            }

            var b = doc.createElement("length-calc"), c = b.style, g = {}, e = {};
            c.position = "absolute";
            c.top = c.left = -9999;
            a.prototype = {bb:/(px|em|ex|mm|cm|in|pt|pc|%)$/, qb:function () {
                var d = g[this.w];
                if (d === void 0)d = g[this.w] = parseFloat(this.w);
                return d
            },
                Ua:function () {
                    var d = e[this.w];
                    if (!d) {
                        d = this.w.match(this.bb);
                        d = e[this.w] = d && d[0] || "px"
                    }
                    return d
                }, a:function (d, f) {
                    var i = this.qb(), j = this.Ua();
                    switch (j) {
                        case "px":
                            return i;
                        case "%":
                            return i * (typeof f === "function" ? f() : f) / 100;
                        case "em":
                            return i * this.ob(d);
                        case "ex":
                            return i * this.ob(d) / 2;
                        default:
                            return i * a.oc[j]
                    }
                }, ob:function (d) {
                    var f = d.currentStyle.fontSize;
                    if (f.indexOf("px") > 0)return parseFloat(f); else {
                        b.style.width = "1em";
                        d.appendChild(b);
                        f = b.offsetWidth;
                        b.parentNode !== d && d.removeChild(b);
                        return f
                    }
                }};
            a.oc = function () {
                var d = ["mm", "cm", "in", "pt", "pc"], f = {}, i = doc.documentElement, j = d.length, k;
                for (i.appendChild(b); j--;) {
                    k = d[j];
                    b.style.width = "100" + k;
                    f[k] = b.offsetWidth / 100
                }
                i.removeChild(b);
                return f
            }();
            a.kb = new a("0");
            return a
        }();
        h.Ha = function () {
            function a(e) {
                this.Q = e
            }

            var b = new h.i("50%"), c = {top:1, center:1, bottom:1}, g = {left:1, center:1, right:1};
            a.prototype = {yc:function () {
                if (!this.nb) {
                    var e = this.Q, d = e.length, f = h.i.kb, i = h.q.fa.ba;
                    f = ["left", f, "top", f];
                    if (d === 1) {
                        e.push({type:i, value:"center"});
                        d++
                    }
                    if (d === 2) {
                        i &
                            (e[0].type | e[1].type) && e[0].value in c && e[1].value in g && e.push(e.shift());
                        if (e[0].type & i)if (e[0].value === "center")f[1] = b; else f[0] = e[0].value; else if (e[0].T())f[1] = new h.i(e[0].value);
                        if (e[1].type & i)if (e[1].value === "center")f[3] = b; else f[2] = e[1].value; else if (e[1].T())f[3] = new h.i(e[1].value)
                    }
                    this.nb = f
                }
                return this.nb
            }, coords:function (e, d, f) {
                var i = this.yc(), j = i[1].a(e, d);
                e = i[3].a(e, f);
                return{x:i[0] === "right" ? d - j : j, y:i[2] === "bottom" ? f - e : e}
            }};
            return a
        }();
        h.Jb = function () {
            function a(b) {
                this.w = b
            }

            a.prototype =
            {bb:/[a-z]+$/i, Ua:function () {
                return this.dc || (this.dc = this.w.match(this.bb)[0].toLowerCase())
            }, qc:function () {
                var b = this.Xb, c;
                if (b === undefined) {
                    b = this.Ua();
                    c = parseFloat(this.w, 10);
                    b = this.Xb = b === "deg" ? c : b === "rad" ? c / Math.PI * 180 : b === "grad" ? c / 400 * 360 : b === "turn" ? c * 360 : 0
                }
                return b
            }};
            return a
        }();
        h.aa = function () {
            function a(b) {
                this.w = b
            }

            a.Mc = /\s*rgba\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d+|\d*\.\d+)\s*\)\s*/;
            a.prototype = {parse:function () {
                if (!this.wa) {
                    var b = this.w, c = b.match(a.Mc);
                    if (c) {
                        this.wa =
                            "rgb(" + c[1] + "," + c[2] + "," + c[3] + ")";
                        this.lb = parseFloat(c[4])
                    } else {
                        this.wa = b;
                        this.lb = b === "transparent" ? 0 : 1
                    }
                }
            }, value:function (b) {
                this.parse();
                return this.wa === "currentColor" ? b.currentStyle.color : this.wa
            }, ha:function () {
                this.parse();
                return this.lb
            }};
            return a
        }();
        h.q = function () {
            function a(c) {
                this.Ba = c;
                this.ch = 0;
                this.Q = [];
                this.ra = 0
            }

            var b = a.fa = {sa:1, hb:2, $:4, Sb:8, ib:16, ba:32, z:64, ca:128, da:256, ua:512, Vb:1024, URL:2048};
            a.jb = function (c, g) {
                this.type = c;
                this.value = g
            };
            a.jb.prototype = {Ya:function () {
                return this.type &
                    b.z || this.type & b.ca && this.value === "0"
            }, T:function () {
                return this.Ya() || this.type & b.ua
            }};
            a.prototype = {Vc:/\s/, Gc:/^[\+\-]?(\d*\.)?\d+/, url:/^url\(\s*("([^"]*)"|'([^']*)'|([!#$%&*-~]*))\s*\)/i, ub:/^\-?[_a-z][\w-]*/i, Qc:/^("([^"]*)"|'([^']*)')/, Ac:/^#([\da-f]{6}|[\da-f]{3})/i, Tc:{px:b.z, em:b.z, ex:b.z, mm:b.z, cm:b.z, "in":b.z, pt:b.z, pc:b.z, deg:b.sa, rad:b.sa, grad:b.sa}, lc:{aqua:1, black:1, blue:1, fuchsia:1, gray:1, green:1, lime:1, maroon:1, navy:1, olive:1, purple:1, red:1, silver:1, teal:1, white:1, yellow:1, currentColor:1},
                kc:{rgb:1, rgba:1, hsl:1, hsla:1}, next:function (c) {
                    function g(u, n) {
                        u = new a.jb(u, n);
                        if (!c) {
                            k.Q.push(u);
                            k.ra++
                        }
                        return u
                    }

                    function e() {
                        k.ra++;
                        return null
                    }

                    var d, f, i, j, k = this;
                    if (this.ra < this.Q.length)return this.Q[this.ra++];
                    for (; this.Vc.test(this.Ba.charAt(this.ch));)this.ch++;
                    if (this.ch >= this.Ba.length)return e();
                    f = this.ch;
                    d = this.Ba.substring(this.ch);
                    i = d.charAt(0);
                    switch (i) {
                        case "#":
                            if (j = d.match(this.Ac)) {
                                this.ch += j[0].length;
                                return g(b.$, j[0])
                            }
                            break;
                        case '"':
                        case "'":
                            if (j = d.match(this.Qc)) {
                                this.ch += j[0].length;
                                return g(b.Vb, j[2] || j[3] || "")
                            }
                            break;
                        case "/":
                        case ",":
                            this.ch++;
                            return g(b.da, i);
                        case "u":
                            if (j = d.match(this.url)) {
                                this.ch += j[0].length;
                                return g(b.URL, j[2] || j[3] || j[4] || "")
                            }
                    }
                    if (j = d.match(this.Gc)) {
                        i = j[0];
                        this.ch += i.length;
                        if (d.charAt(i.length) === "%") {
                            this.ch++;
                            return g(b.ua, i + "%")
                        }
                        if (j = d.substring(i.length).match(this.ub)) {
                            i += j[0];
                            this.ch += j[0].length;
                            return g(this.Tc[j[0].toLowerCase()] || b.Sb, i)
                        }
                        return g(b.ca, i)
                    }
                    if (j = d.match(this.ub)) {
                        i = j[0];
                        this.ch += i.length;
                        if (i.toLowerCase()in this.lc)return g(b.$,
                            i);
                        if (d.charAt(i.length) === "(") {
                            this.ch++;
                            if (i.toLowerCase()in this.kc) {
                                d = function (u) {
                                    return u && u.type & b.ca
                                };
                                j = function (u) {
                                    return u && u.type & (b.ca | b.ua)
                                };
                                var m = function (u, n) {
                                    return u && u.value === n
                                }, l = function () {
                                    return k.next(1)
                                };
                                if ((i.charAt(0) === "r" ? j(l()) : d(l())) && m(l(), ",") && j(l()) && m(l(), ",") && j(l()) && (i === "rgb" || i === "hsa" || m(l(), ",") && d(l())) && m(l(), ")"))return g(b.$, this.Ba.substring(f, this.ch));
                                return e()
                            }
                            return g(b.ib, i + "(")
                        }
                        return g(b.ba, i)
                    }
                    this.ch++;
                    return g(b.hb, i)
                }, v:function () {
                    return this.Q[this.ra-- -
                        2]
                }, all:function () {
                    for (; this.next(););
                    return this.Q
                }, Z:function (c, g) {
                    for (var e = [], d, f; d = this.next();) {
                        if (c(d)) {
                            f = true;
                            this.v();
                            break
                        }
                        e.push(d)
                    }
                    return g && !f ? null : e
                }};
            return a
        }();
        var K = function (a) {
            this.d = a
        };
        K.prototype = {J:0, Kc:function () {
            var a = this.Oa, b;
            return!a || (b = this.m()) && (a.x !== b.x || a.y !== b.y)
        }, Nc:function () {
            var a = this.Oa, b;
            return!a || (b = this.m()) && (a.g !== b.g || a.e !== b.e)
        }, pb:function () {
            var a = this.d.getBoundingClientRect();
            return{x:a.left, y:a.top, g:a.right - a.left, e:a.bottom - a.top}
        }, m:function () {
            return this.J ?
                this.xa || (this.xa = this.pb()) : this.pb()
        }, zc:function () {
            return!!this.Oa
        }, Da:function () {
            ++this.J
        }, Fa:function () {
            if (!--this.J) {
                if (this.xa)this.Oa = this.xa;
                this.xa = null
            }
        }};
        (function () {
            function a(b) {
                var c = h.n.oa(b);
                return function () {
                    if (this.J) {
                        var g = this.mb || (this.mb = {});
                        return c in g ? g[c] : (g[c] = b.call(this))
                    } else return b.call(this)
                }
            }

            h.p = {J:0, V:function (b) {
                function c(g) {
                    this.d = g
                }

                h.n.$a(c.prototype, h.p, b);
                c.cc = {};
                return c
            }, j:function () {
                var b = this.la(), c = this.constructor.cc;
                return b ? b in c ? c[b] : (c[b] = this.X(b)) :
                    null
            }, la:a(function () {
                var b = this.d, c = this.constructor, g = b.style;
                b = b.currentStyle;
                var e = this.ja, d = this.qa, f = c.ac || (c.ac = h.I + e);
                c = c.bc || (c.bc = h.Na + d.charAt(0).toUpperCase() + d.substring(1));
                return g[c] || b.getAttribute(f) || g[d] || b.getAttribute(e)
            }), f:a(function () {
                return!!this.j()
            }), C:a(function () {
                var b = this.la(), c = b !== this.Zb;
                this.Zb = b;
                return c
            }), ia:a, Da:function () {
                ++this.J
            }, Fa:function () {
                --this.J || delete this.mb
            }}
        })();
        h.Lb = h.p.V({ja:h.I + "background", qa:h.Na + "Background", gc:{scroll:1, fixed:1, local:1},
            Ea:{"repeat-x":1, "repeat-y":1, repeat:1, "no-repeat":1}, Hc:{"padding-box":1, "border-box":1, "content-box":1}, jc:{"padding-box":1, "border-box":1}, Lc:{top:1, right:1, bottom:1, left:1, center:1}, Oc:{contain:1, cover:1}, X:function (a) {
                function b(v) {
                    return v.T() || v.type & j && v.value in u
                }

                function c(v) {
                    return v.T() && new h.i(v.value) || v.value === "auto" && "auto"
                }

                var g = this.d.currentStyle, e, d, f = h.q.fa, i = f.da, j = f.ba, k = f.$, m, l, u = this.Lc, n, q, t = null;
                if (this.Ta()) {
                    a = new h.q(a);
                    t = {images:[]};
                    for (d = {}; e = a.next();) {
                        m = e.type;
                        l = e.value;
                        if (!d.type && m & f.ib && l === "linear-gradient(") {
                            n = {Y:[], type:"linear-gradient"};
                            for (q = {}; e = a.next();) {
                                m = e.type;
                                l = e.value;
                                if (m & f.hb && l === ")") {
                                    q.color && n.Y.push(q);
                                    n.Y.length > 1 && h.n.$a(d, n);
                                    break
                                }
                                if (m & k) {
                                    if (n.Ra || n.Va) {
                                        e = a.v();
                                        if (e.type !== i)break;
                                        a.next()
                                    }
                                    q = {color:new h.aa(l)};
                                    e = a.next();
                                    if (e.T())q.xb = new h.i(e.value); else a.v()
                                } else if (m & f.sa && !n.Ra && !q.color && !n.Y.length)n.Ra = new h.Jb(e.value); else if (b(e) && !n.Va && !q.color && !n.Y.length) {
                                    a.v();
                                    n.Va = new h.Ha(a.Z(function (v) {
                                        return!b(v)
                                    }, false))
                                } else if (m &
                                    i && l === ",") {
                                    if (q.color) {
                                        n.Y.push(q);
                                        q = {}
                                    }
                                } else break
                            }
                        } else if (!d.type && m & f.URL) {
                            d.url = l;
                            d.type = "image"
                        } else if (b(e) && !d.size) {
                            a.v();
                            d.position = new h.Ha(a.Z(function (v) {
                                return!b(v)
                            }, false))
                        } else if (m & j)if (l in this.Ea)d.repeat = l; else if (l in this.Hc) {
                            d.origin = l;
                            if (l in this.jc)d.clip = l
                        } else {
                            if (l in this.gc)d.Zc = l
                        } else if (m & k && !t.color)t.color = new h.aa(l); else if (m & i)if (l === "/") {
                            e = a.next();
                            m = e.type;
                            l = e.value;
                            if (m & j && l in this.Oc)d.size = l; else if (l = c(e))d.size = {g:l, e:c(a.next()) || a.v() && l}
                        } else {
                            if (l ===
                                "," && d.type) {
                                t.images.push(d);
                                d = {}
                            }
                        } else return null
                    }
                    d.type && t.images.push(d)
                } else this.Fb(function () {
                    var v = g.backgroundPositionX, x = g.backgroundPositionY, r = g.backgroundImage, o = g.backgroundColor;
                    t = {};
                    if (o !== "transparent")t.color = new h.aa(o);
                    if (r !== "none")t.images = [
                        {type:"image", url:(new h.q(r)).next().value, repeat:g.backgroundRepeat, position:new h.Ha((new h.q(v + " " + x)).all())}
                    ]
                });
                return t && (t.color || t.images && t.images[0]) ? t : null
            }, Fb:function (a) {
                var b = this.d.runtimeStyle, c = b.backgroundImage, g = b.backgroundColor;
                if (c)b.backgroundImage = "";
                if (g)b.backgroundColor = "";
                a = a.call(this);
                if (c)b.backgroundImage = c;
                if (g)b.backgroundColor = g;
                return a
            }, la:h.p.ia(function () {
                return this.Ta() || this.Fb(function () {
                    var a = this.d.currentStyle;
                    return a.backgroundColor + " " + a.backgroundImage + " " + a.backgroundRepeat + " " + a.backgroundPositionX + " " + a.backgroundPositionY
                })
            }), Ta:h.p.ia(function () {
                var a = this.d;
                return a.style[this.qa] || a.currentStyle.getAttribute(this.ja)
            }), wb:function () {
                var a = 0;
                if (h.D < 7) {
                    a = this.d;
                    a = "" + (a.style[h.Na + "PngFix"] ||
                        a.currentStyle.getAttribute(h.I + "png-fix")) === "true"
                }
                return a
            }, f:h.p.ia(function () {
                return(this.Ta() || this.wb()) && !!this.j()
            })});
        h.Pb = h.p.V({Ab:["Top", "Right", "Bottom", "Left"], Fc:{bd:"1px", $c:"3px", ad:"5px"}, X:function () {
            var a = {}, b = {}, c = {}, g = false, e = true, d = true, f = true;
            this.Gb(function () {
                for (var i = this.d.currentStyle, j = 0, k, m, l, u, n, q, t; j < 4; j++) {
                    l = this.Ab[j];
                    t = l.charAt(0).toLowerCase();
                    k = b[t] = i["border" + l + "Style"];
                    m = i["border" + l + "Color"];
                    l = i["border" + l + "Width"];
                    if (j > 0) {
                        if (k !== u)d = false;
                        if (m !== n)e = false;
                        if (l !== q)f = false
                    }
                    u = k;
                    n = m;
                    q = l;
                    c[t] = new h.aa(m);
                    l = a[t] = new h.i(b[t] === "none" ? "0" : this.Fc[l] || l);
                    if (l.a(this.d) > 0)g = true
                }
            });
            return g ? {gb:a, Rc:b, mc:c, Wc:f, nc:e, Sc:d} : null
        }, la:h.p.ia(function () {
            var a = this.d, b = a.currentStyle, c;
            a.tagName in h.Bb && a.offsetParent.currentStyle.borderCollapse === "collapse" || this.Gb(function () {
                c = b.borderWidth + "|" + b.borderStyle + "|" + b.borderColor
            });
            return c
        }), Gb:function (a) {
            var b = this.d.runtimeStyle, c = b.borderWidth, g = b.borderColor;
            if (c)b.borderWidth = "";
            if (g)b.borderColor = "";
            a = a.call(this);
            if (c)b.borderWidth = c;
            if (g)b.borderColor = g;
            return a
        }});
        (function () {
            h.Ia = h.p.V({ja:"border-radius", qa:"borderRadius", X:function (b) {
                var c = null, g, e, d, f, i = false;
                if (b) {
                    e = new h.q(b);
                    var j = function () {
                        for (var k = [], m; (d = e.next()) && d.T();) {
                            f = new h.i(d.value);
                            m = f.qb();
                            if (m < 0)return null;
                            if (m > 0)i = true;
                            k.push(f)
                        }
                        return k.length > 0 && k.length < 5 ? {tl:k[0], tr:k[1] || k[0], br:k[2] || k[0], bl:k[3] || k[1] || k[0]} : null
                    };
                    if (b = j()) {
                        if (d) {
                            if (d.type & h.q.fa.da && d.value === "/")g = j()
                        } else g = b;
                        if (i && b && g)c = {x:b, y:g}
                    }
                }
                return c
            }});
            var a =
                h.i.kb;
            a = {tl:a, tr:a, br:a, bl:a};
            h.Ia.Ib = {x:a, y:a}
        })();
        h.Nb = h.p.V({ja:"border-image", qa:"borderImage", Ea:{stretch:1, round:1, repeat:1, space:1}, X:function (a) {
            var b = null, c, g, e, d, f, i, j = 0, k, m = h.q.fa, l = m.ba, u = m.ca, n = m.z, q = m.ua;
            if (a) {
                c = new h.q(a);
                b = {};
                for (var t = function (r) {
                    return r && r.type & m.da && r.value === "/"
                }, v = function (r) {
                    return r && r.type & l && r.value === "fill"
                }, x = function () {
                    d = c.Z(function (r) {
                        return!(r.type & (u | q))
                    });
                    if (v(c.next()) && !b.fill)b.fill = true; else c.v();
                    if (t(c.next())) {
                        j++;
                        f = c.Z(function () {
                            return!(g.type &
                                (u | q | n)) && !(g.type & l && g.value === "auto")
                        });
                        if (t(c.next())) {
                            j++;
                            i = c.Z(function () {
                                return!(g.type & (u | n))
                            })
                        }
                    } else c.v()
                }; g = c.next();) {
                    a = g.type;
                    e = g.value;
                    if (a & (u | q) && !d) {
                        c.v();
                        x()
                    } else if (v(g) && !b.fill) {
                        b.fill = true;
                        x()
                    } else if (a & l && this.Ea[e] && !b.repeat) {
                        b.repeat = {e:e};
                        if (g = c.next())if (g.type & l && this.Ea[g.value])b.repeat.db = g.value; else c.v()
                    } else if (a & m.URL && !b.src)b.src = e; else return null
                }
                if (!b.src || !d || d.length < 1 || d.length > 4 || f && f.length > 4 || j === 1 && f.length < 1 || i && i.length > 4 || j === 2 && i.length < 1)return null;
                if (!b.repeat)b.repeat = {e:"stretch"};
                if (!b.repeat.db)b.repeat.db = b.repeat.e;
                a = function (r, o) {
                    return{P:o(r[0]), O:o(r[1] || r[0]), K:o(r[2] || r[0]), M:o(r[3] || r[1] || r[0])}
                };
                b.slice = a(d, function (r) {
                    return new h.i(r.type & u ? r.value + "px" : r.value)
                });
                b.width = f && f.length > 0 ? a(f, function (r) {
                    return r.type & (n | q) ? new h.i(r.value) : r.value
                }) : (k = this.d.currentStyle) && {P:new h.i(k.borderTopWidth), O:new h.i(k.borderRightWidth), K:new h.i(k.borderBottomWidth), M:new h.i(k.borderLeftWidth)};
                b.pa = a(i || [0], function (r) {
                    return r.type &
                        n ? new h.i(r.value) : r.value
                })
            }
            return b
        }});
        h.Rb = h.p.V({ja:"box-shadow", qa:"boxShadow", X:function (a) {
            var b, c = h.i, g = h.q.fa, e;
            if (a) {
                e = new h.q(a);
                b = {pa:[], Xa:[]};
                for (a = function () {
                    for (var d, f, i, j, k, m; d = e.next();) {
                        i = d.value;
                        f = d.type;
                        if (f & g.da && i === ",")break; else if (d.Ya() && !k) {
                            e.v();
                            k = e.Z(function (l) {
                                return!l.Ya()
                            })
                        } else if (f & g.$ && !j)j = i; else if (f & g.ba && i === "inset" && !m)m = true; else return false
                    }
                    d = k && k.length;
                    if (d > 1 && d < 5) {
                        (m ? b.Xa : b.pa).push({Xc:new c(k[0].value), Yc:new c(k[1].value), blur:new c(k[2] ? k[2].value :
                            "0"), Pc:new c(k[3] ? k[3].value : "0"), color:new h.aa(j || "currentColor")});
                        return true
                    }
                    return false
                }; a(););
            }
            return b && (b.Xa.length || b.pa.length) ? b : null
        }});
        h.Wb = h.p.V({la:h.p.ia(function () {
            var a = this.d.currentStyle;
            return a.visibility + "|" + a.display
        }), X:function () {
            var a = this.d, b = a.runtimeStyle;
            a = a.currentStyle;
            var c = b.visibility, g;
            b.visibility = "";
            g = a.visibility;
            b.visibility = c;
            return{Uc:g !== "hidden", sc:a.display !== "none"}
        }, f:function () {
            return false
        }});
        h.A = {U:function (a) {
            function b(c, g, e, d) {
                this.d = c;
                this.o =
                    g;
                this.h = e;
                this.parent = d
            }

            h.n.$a(b.prototype, h.A, a);
            return b
        }, Za:false, N:function () {
            return false
        }, Cb:function () {
            this.k();
            this.f() && this.S()
        }, cb:function () {
            this.Za = true
        }, Db:function () {
            this.f() ? this.S() : this.k()
        }, Qa:function (a, b) {
            this.zb(a);
            for (var c = this.ga || (this.ga = []), g = a + 1, e = c.length, d; g < e; g++)if (d = c[g])break;
            c[a] = b;
            this.u().insertBefore(b, d || null)
        }, ma:function (a) {
            var b = this.ga;
            return b && b[a] || null
        }, zb:function (a) {
            var b = this.ma(a), c = this.va;
            if (b && c) {
                c.removeChild(b);
                this.ga[a] = null
            }
        }, na:function (a, b, c, g) {
            var e = this.Pa || (this.Pa = {}), d = e[a];
            if (!d) {
                d = e[a] = h.n.Aa("shape");
                if (b)d.appendChild(d[b] = h.n.Aa(b));
                if (g) {
                    c = this.ma(g);
                    if (!c) {
                        this.Qa(g, doc.createElement("group" + g));
                        c = this.ma(g)
                    }
                }
                c.appendChild(d);
                a = d.style;
                a.position = "absolute";
                a.left = a.top = 0;
                a.behavior = "url(#default#VML)"
            }
            return d
        }, Sa:function (a) {
            var b = this.Pa, c = b && b[a];
            if (c) {
                c.parentNode.removeChild(c);
                delete b[a]
            }
            return!!c
        }, sb:function (a) {
            var b = this.d, c = this.o.m(), g = c.g, e = c.e, d, f, i, j, k, m;
            c = a.x.tl.a(b, g);
            d = a.y.tl.a(b, e);
            f = a.x.tr.a(b, g);
            i = a.y.tr.a(b, e);
            j = a.x.br.a(b, g);
            k = a.y.br.a(b, e);
            m = a.x.bl.a(b, g);
            a = a.y.bl.a(b, e);
            g = Math.min(g / (c + f), e / (i + k), g / (m + j), e / (d + a));
            if (g < 1) {
                c *= g;
                d *= g;
                f *= g;
                i *= g;
                j *= g;
                k *= g;
                m *= g;
                a *= g
            }
            return{x:{tl:c, tr:f, br:j, bl:m}, y:{tl:d, tr:i, br:k, bl:a}}
        }, ka:function (a, b, c) {
            b = b || 1;
            var g, e, d = this.o.m();
            e = d.g * b;
            d = d.e * b;
            var f = this.h.s, i = Math.floor, j = Math.ceil, k = a ? a.P * b : 0, m = a ? a.O * b : 0, l = a ? a.K * b : 0;
            a = a ? a.M * b : 0;
            var u, n, q, t, v;
            if (c || f.f()) {
                g = this.sb(c || f.j());
                c = g.x.tl * b;
                f = g.y.tl * b;
                u = g.x.tr * b;
                n = g.y.tr * b;
                q = g.x.br * b;
                t = g.y.br * b;
                v = g.x.bl *
                    b;
                b = g.y.bl * b;
                e = "m" + i(a) + "," + i(f) + "qy" + i(c) + "," + i(k) + "l" + j(e - u) + "," + i(k) + "qx" + j(e - m) + "," + i(n) + "l" + j(e - m) + "," + j(d - t) + "qy" + j(e - q) + "," + j(d - l) + "l" + i(v) + "," + j(d - l) + "qx" + i(a) + "," + j(d - b) + " x e"
            } else e = "m" + i(a) + "," + i(k) + "l" + j(e - m) + "," + i(k) + "l" + j(e - m) + "," + j(d - l) + "l" + i(a) + "," + j(d - l) + "xe";
            return e
        }, u:function () {
            var a = this.parent.ma(this.B), b;
            if (!a) {
                a = doc.createElement(this.za);
                b = a.style;
                b.position = "absolute";
                b.top = b.left = 0;
                this.parent.Qa(this.B, a)
            }
            return a
        }, k:function () {
            this.parent.zb(this.B);
            delete this.Pa;
            delete this.ga
        }};
        h.Ub = h.A.U({f:function () {
            var a = this.hc;
            for (var b in a)if (a.hasOwnProperty(b) && a[b].f())return true;
            return false
        }, N:function () {
            return this.h.eb.C()
        }, cb:function () {
            if (this.f()) {
                var a = this.rb(), b = a, c;
                a = a.currentStyle;
                var g = a.position, e = this.u().style, d = 0, f = 0;
                f = this.o.m();
                if (g === "fixed" && h.D > 6) {
                    d = f.x;
                    f = f.y;
                    b = g
                } else {
                    do b = b.offsetParent; while (b && b.currentStyle.position === "static");
                    if (b) {
                        c = b.getBoundingClientRect();
                        b = b.currentStyle;
                        d = f.x - c.left - (parseFloat(b.borderLeftWidth) || 0);
                        f = f.y - c.top -
                            (parseFloat(b.borderTopWidth) || 0)
                    } else {
                        b = doc.documentElement;
                        d = f.x + b.scrollLeft - b.clientLeft;
                        f = f.y + b.scrollTop - b.clientTop
                    }
                    b = "absolute"
                }
                e.position = b;
                e.left = d;
                e.top = f;
                e.zIndex = g === "static" ? -1 : a.zIndex;
                this.Za = true
            }
        }, Db:function () {
        }, Eb:function () {
            var a = this.h.eb.j();
            this.u().style.display = a.Uc && a.sc ? "" : "none"
        }, Cb:function () {
            this.f() ? this.Eb() : this.k()
        }, rb:function () {
            var a = this.d;
            return a.tagName in h.Bb ? a.offsetParent : a
        }, u:function () {
            var a = this.va, b;
            if (!a) {
                b = this.rb();
                a = this.va = doc.createElement("css3-container");
                this.Eb();
                b.parentNode.insertBefore(a, b)
            }
            return a
        }, k:function () {
            var a = this.va, b;
            if (a && (b = a.parentNode))b.removeChild(a);
            delete this.va;
            delete this.ga
        }});
        h.Kb = h.A.U({B:2, za:"background", N:function () {
            var a = this.h;
            return a.G.C() || a.s.C()
        }, f:function () {
            var a = this.h;
            return a.L.f() || a.s.f() || a.G.f() || a.R.f() && a.R.j().Xa
        }, S:function () {
            var a = this.o.m();
            if (a.g && a.e) {
                this.tc();
                this.uc()
            }
        }, tc:function () {
            var a = this.h.G.j(), b = this.o.m(), c = this.d, g = a && a.color, e, d;
            if (g && g.ha() > 0) {
                this.tb();
                a = this.na("bgColor", "fill",
                    this.u(), 1);
                e = b.g;
                b = b.e;
                a.stroked = false;
                a.coordsize = e * 2 + "," + b * 2;
                a.coordorigin = "1,1";
                a.path = this.ka(null, 2);
                d = a.style;
                d.width = e;
                d.height = b;
                a.fill.color = g.value(c);
                c = g.ha();
                if (c < 1)a.fill.opacity = c
            } else this.Sa("bgColor")
        }, uc:function () {
            var a = this.h.G.j(), b = this.o.m();
            a = a && a.images;
            var c, g, e, d, f;
            if (a) {
                this.tb();
                g = b.g;
                e = b.e;
                for (f = a.length; f--;) {
                    b = a[f];
                    c = this.na("bgImage" + f, "fill", this.u(), 2);
                    c.stroked = false;
                    c.fill.type = "tile";
                    c.fillcolor = "none";
                    c.coordsize = g * 2 + "," + e * 2;
                    c.coordorigin = "1,1";
                    c.path = this.ka(0,
                        2);
                    d = c.style;
                    d.width = g;
                    d.height = e;
                    if (b.type === "linear-gradient")this.fc(c, b); else {
                        c.fill.src = b.url;
                        this.Jc(c, f)
                    }
                }
            }
            for (f = a ? a.length : 0; this.Sa("bgImage" + f++););
        }, Jc:function (a, b) {
            h.n.Hb(a.fill.src, function (c) {
                var g = a.fill, e = this.d, d = this.o.m(), f = d.g;
                d = d.e;
                var i = this.h, j = i.H.j(), k = j && j.gb;
                j = k ? k.t.a(e) : 0;
                var m = k ? k.r.a(e) : 0, l = k ? k.b.a(e) : 0;
                k = k ? k.l.a(e) : 0;
                i = i.G.j().images[b];
                e = i.position ? i.position.coords(e, f - c.g - k - m, d - c.e - j - l) : {x:0, y:0};
                i = i.repeat;
                l = m = 0;
                var u = f + 1, n = d + 1, q = h.D === 8 ? 0 : 1;
                k = Math.round(e.x) + k +
                    0.5;
                j = Math.round(e.y) + j + 0.5;
                g.position = k / f + "," + j / d;
                if (i && i !== "repeat") {
                    if (i === "repeat-x" || i === "no-repeat") {
                        m = j + 1;
                        n = j + c.e + q
                    }
                    if (i === "repeat-y" || i === "no-repeat") {
                        l = k + 1;
                        u = k + c.g + q
                    }
                    a.style.clip = "rect(" + m + "px," + u + "px," + n + "px," + l + "px)"
                }
            }, this)
        }, fc:function (a, b) {
            function c(A, B, y, G, H) {
                if (y === 0 || y === 180)return[G, B]; else if (y === 90 || y === 270)return[A, H]; else {
                    y = Math.tan(-y * u / 180);
                    A = y * A - B;
                    B = -1 / y;
                    G = B * G - H;
                    H = B - y;
                    return[(G - A) / H, (y * G - B * A) / H]
                }
            }

            function g() {
                x = m >= 90 && m < 270 ? j : 0;
                r = m < 180 ? k : 0;
                o = j - x;
                s = k - r
            }

            function e() {
                for (; m <
                           0;)m += 360;
                m %= 360
            }

            function d(A, B) {
                var y = B[0] - A[0];
                A = B[1] - A[1];
                return Math.abs(y === 0 ? A : A === 0 ? y : Math.sqrt(y * y + A * A))
            }

            var f = this.d, i = this.o.m(), j = i.g, k = i.e;
            a = a.fill;
            var m = b.Ra, l = b.Va;
            b = b.Y;
            i = b.length;
            var u = Math.PI, n, q, t, v, x, r, o, s, p, z, E, C;
            if (l) {
                l = l.coords(f, j, k);
                n = l.x;
                q = l.y
            }
            if (m) {
                m = m.qc();
                e();
                g();
                if (!l) {
                    n = x;
                    q = r
                }
                l = c(n, q, m, o, s);
                t = l[0];
                v = l[1]
            } else if (l) {
                t = j - n;
                v = k - q
            } else {
                n = q = t = 0;
                v = k
            }
            l = t - n;
            p = v - q;
            if (m === void 0) {
                m = !l ? p < 0 ? 90 : 270 : !p ? l < 0 ? 180 : 0 : -Math.atan2(p, l) / u * 180;
                e();
                g()
            }
            l = m % 90 ? Math.atan2(l * j / k, p) / u * 180 : m + 90;
            l += 180;
            l %= 360;
            z = d([n, q], [t, v]);
            t = d([x, r], c(x, r, m, o, s));
            v = [];
            q = d([n, q], c(n, q, m, x, r)) / t * 100;
            n = [];
            for (p = 0; p < i; p++)n.push(b[p].xb ? b[p].xb.a(f, z) : p === 0 ? 0 : p === i - 1 ? z : null);
            for (p = 1; p < i; p++) {
                if (n[p] === null) {
                    E = n[p - 1];
                    z = p;
                    do C = n[++z]; while (C === null);
                    n[p] = E + (C - E) / (z - p + 1)
                }
                n[p] = Math.max(n[p], n[p - 1])
            }
            for (p = 0; p < i; p++)v.push(q + n[p] / t * 100 + "% " + b[p].color.value(f));
            a.angle = l;
            a.type = "gradient";
            a.method = "sigma";
            a.color = b[0].color.value(f);
            a.color2 = b[i - 1].color.value(f);
            a.colors.value = v.join(",")
        }, tb:function () {
            var a =
                this.d.runtimeStyle;
            a.backgroundImage = "url(about:blank)";
            a.backgroundColor = "transparent"
        }, k:function () {
            h.A.k.call(this);
            var a = this.d.runtimeStyle;
            a.backgroundImage = a.backgroundColor = ""
        }});
        h.Ob = h.A.U({B:4, za:"border", ic:{TABLE:1, INPUT:1, TEXTAREA:1, SELECT:1, OPTION:1, IMG:1, HR:1, FIELDSET:1}, Ec:{submit:1, button:1, reset:1}, N:function () {
            var a = this.h;
            return a.H.C() || a.s.C()
        }, f:function () {
            var a = this.h;
            return(a.L.f() || a.s.f() || a.G.f()) && a.H.f()
        }, S:function () {
            var a = this.d, b = this.h.H.j(), c = this.o.m(), g = c.g;
            c =
                c.e;
            var e, d, f, i, j;
            if (b) {
                this.Cc();
                b = this.wc(2);
                i = 0;
                for (j = b.length; i < j; i++) {
                    f = b[i];
                    e = this.na("borderPiece" + i, f.stroke ? "stroke" : "fill", this.u());
                    e.coordsize = g * 2 + "," + c * 2;
                    e.coordorigin = "1,1";
                    e.path = f.path;
                    d = e.style;
                    d.width = g;
                    d.height = c;
                    e.filled = !!f.fill;
                    e.stroked = !!f.stroke;
                    if (f.stroke) {
                        e = e.stroke;
                        e.weight = f.fb + "px";
                        e.color = f.color.value(a);
                        e.dashstyle = f.stroke === "dashed" ? "2 2" : f.stroke === "dotted" ? "1 1" : "solid";
                        e.linestyle = f.stroke === "double" && f.fb > 2 ? "ThinThin" : "Single"
                    } else e.fill.color = f.fill.value(a)
                }
                for (; this.Sa("borderPiece" +
                    i++););
            }
        }, Cc:function () {
            var a = this.d, b = a.currentStyle, c = a.runtimeStyle, g = a.tagName, e = h.D === 6, d;
            if (e && g in this.ic || g === "BUTTON" || g === "INPUT" && a.type in this.Ec) {
                c.borderWidth = "";
                g = this.h.H.Ab;
                for (d = g.length; d--;) {
                    e = g[d];
                    c["padding" + e] = "";
                    c["padding" + e] = (new h.i(b["padding" + e])).a(a) + (new h.i(b["border" + e + "Width"])).a(a) + (!h.D === 8 && d % 2 ? 1 : 0)
                }
                c.borderWidth = 0
            } else if (e) {
                if (a.childNodes.length !== 1 || a.firstChild.tagName !== "ie6-mask") {
                    b = doc.createElement("ie6-mask");
                    g = b.style;
                    g.visibility = "visible";
                    for (g.zoom =
                             1; g = a.firstChild;)b.appendChild(g);
                    a.appendChild(b);
                    c.visibility = "hidden"
                }
            } else c.borderColor = "transparent"
        }, wc:function (a) {
            var b = this.d, c, g, e, d = this.h.H, f = [], i, j, k, m, l = Math.round, u, n, q;
            if (d.f()) {
                c = d.j();
                d = c.gb;
                n = c.Rc;
                q = c.mc;
                if (c.Wc && c.Sc && c.nc) {
                    if (q.t.ha() > 0) {
                        c = d.t.a(b);
                        k = c / 2;
                        f.push({path:this.ka({P:k, O:k, K:k, M:k}, a), stroke:n.t, color:q.t, fb:c})
                    }
                } else {
                    a = a || 1;
                    c = this.o.m();
                    g = c.g;
                    e = c.e;
                    c = l(d.t.a(b));
                    k = l(d.r.a(b));
                    m = l(d.b.a(b));
                    b = l(d.l.a(b));
                    var t = {t:c, r:k, b:m, l:b};
                    b = this.h.s;
                    if (b.f())u = this.sb(b.j());
                    i = Math.floor;
                    j = Math.ceil;
                    var v = function (o, s) {
                        return u ? u[o][s] : 0
                    }, x = function (o, s, p, z, E, C) {
                        var A = v("x", o), B = v("y", o), y = o.charAt(1) === "r";
                        o = o.charAt(0) === "b";
                        return A > 0 && B > 0 ? (C ? "al" : "ae") + (y ? j(g - A) : i(A)) * a + "," + (o ? j(e - B) : i(B)) * a + "," + (i(A) - s) * a + "," + (i(B) - p) * a + "," + z * 65535 + "," + 2949075 * (E ? 1 : -1) : (C ? "m" : "l") + (y ? g - s : s) * a + "," + (o ? e - p : p) * a
                    }, r = function (o, s, p, z) {
                        var E = o === "t" ? i(v("x", "tl")) * a + "," + j(s) * a : o === "r" ? j(g - s) * a + "," + i(v("y", "tr")) * a : o === "b" ? j(g - v("x", "br")) * a + "," + i(e - s) * a : i(s) * a + "," + j(e - v("y", "bl")) * a;
                        o =
                            o === "t" ? j(g - v("x", "tr")) * a + "," + j(s) * a : o === "r" ? j(g - s) * a + "," + j(e - v("y", "br")) * a : o === "b" ? i(v("x", "bl")) * a + "," + i(e - s) * a : i(s) * a + "," + i(v("y", "tl")) * a;
                        return p ? (z ? "m" + o : "") + "l" + E : (z ? "m" + E : "") + "l" + o
                    };
                    b = function (o, s, p, z, E, C) {
                        var A = o === "l" || o === "r", B = t[o], y, G;
                        if (B > 0 && n[o] !== "none" && q[o].ha() > 0) {
                            y = t[A ? o : s];
                            s = t[A ? s : o];
                            G = t[A ? o : p];
                            p = t[A ? p : o];
                            if (n[o] === "dashed" || n[o] === "dotted") {
                                f.push({path:x(z, y, s, C + 45, 0, 1) + x(z, 0, 0, C, 1, 0), fill:q[o]});
                                f.push({path:r(o, B / 2, 0, 1), stroke:n[o], fb:B, color:q[o]});
                                f.push({path:x(E, G, p,
                                    C, 0, 1) + x(E, 0, 0, C - 45, 1, 0), fill:q[o]})
                            } else f.push({path:x(z, y, s, C + 45, 0, 1) + r(o, B, 0, 0) + x(E, G, p, C, 0, 0) + (n[o] === "double" && B > 2 ? x(E, G - i(G / 3), p - i(p / 3), C - 45, 1, 0) + r(o, j(B / 3 * 2), 1, 0) + x(z, y - i(y / 3), s - i(s / 3), C, 1, 0) + "x " + x(z, i(y / 3), i(s / 3), C + 45, 0, 1) + r(o, i(B / 3), 1, 0) + x(E, i(G / 3), i(p / 3), C, 0, 0) : "") + x(E, 0, 0, C - 45, 1, 0) + r(o, 0, 1, 0) + x(z, 0, 0, C, 1, 0), fill:q[o]})
                        }
                    };
                    b("t", "l", "r", "tl", "tr", 90);
                    b("r", "t", "b", "tr", "br", 0);
                    b("b", "r", "l", "br", "bl", -90);
                    b("l", "b", "t", "bl", "tl", -180)
                }
            }
            return f
        }, k:function () {
            h.A.k.call(this);
            this.d.runtimeStyle.borderColor =
                ""
        }});
        h.Mb = h.A.U({B:5, Ic:["t", "tr", "r", "br", "b", "bl", "l", "tl", "c"], N:function () {
            return this.h.L.C()
        }, f:function () {
            return this.h.L.f()
        }, S:function () {
            var a = this.h.L.j(), b = this.o.m();
            this.u();
            var c = this.d, g = this.yb;
            h.n.Hb(a.src, function (e) {
                function d(x, r, o, s, p) {
                    x = g[x].style;
                    x.width = r;
                    x.height = o;
                    x.left = s;
                    x.top = p
                }

                function f(x, r, o) {
                    for (var s = 0, p = x.length; s < p; s++)g[x[s]].imagedata[r] = o
                }

                var i = b.g, j = b.e, k = a.width, m = k.P.a(c), l = k.O.a(c), u = k.K.a(c);
                k = k.M.a(c);
                var n = a.slice, q = n.P.a(c), t = n.O.a(c), v = n.K.a(c);
                n =
                    n.M.a(c);
                d("tl", k, m, 0, 0);
                d("t", i - k - l, m, k, 0);
                d("tr", l, m, i - l, 0);
                d("r", l, j - m - u, i - l, m);
                d("br", l, u, i - l, j - u);
                d("b", i - k - l, u, k, j - u);
                d("bl", k, u, 0, j - u);
                d("l", k, j - m - u, 0, m);
                d("c", i - k - l, j - m - u, k, m);
                f(["tl", "t", "tr"], "cropBottom", (e.e - q) / e.e);
                f(["tl", "l", "bl"], "cropRight", (e.g - n) / e.g);
                f(["bl", "b", "br"], "cropTop", (e.e - v) / e.e);
                f(["tr", "r", "br"], "cropLeft", (e.g - t) / e.g);
                if (a.repeat.db === "stretch") {
                    f(["l", "r", "c"], "cropTop", q / e.e);
                    f(["l", "r", "c"], "cropBottom", v / e.e)
                }
                if (a.repeat.e === "stretch") {
                    f(["t", "b", "c"], "cropLeft",
                        n / e.g);
                    f(["t", "b", "c"], "cropRight", t / e.g)
                }
                g.c.style.display = a.fill ? "" : "none"
            }, this)
        }, u:function () {
            var a = this.parent.ma(this.B), b, c, g, e = this.Ic, d = e.length;
            if (!a) {
                a = doc.createElement("border-image");
                b = a.style;
                b.position = "absolute";
                this.yb = {};
                for (g = 0; g < d; g++) {
                    c = this.yb[e[g]] = h.n.Aa("rect");
                    c.appendChild(h.n.Aa("imagedata"));
                    b = c.style;
                    b.behavior = "url(#default#VML)";
                    b.position = "absolute";
                    b.top = b.left = 0;
                    c.imagedata.src = this.h.L.j().src;
                    c.stroked = false;
                    c.filled = false;
                    a.appendChild(c)
                }
                this.parent.Qa(this.B,
                    a)
            }
            return a
        }});
        h.Qb = h.A.U({B:1, za:"outset-box-shadow", N:function () {
            var a = this.h;
            return a.R.C() || a.s.C()
        }, f:function () {
            var a = this.h.R;
            return a.f() && a.j().pa[0]
        }, S:function () {
            function a(y, G, H, w, D, F, I) {
                y = b.na("shadow" + y + G, "fill", g, f - y);
                G = y.fill;
                y.coordsize = m * 2 + "," + l * 2;
                y.coordorigin = "1,1";
                y.stroked = false;
                y.filled = true;
                G.color = D.value(c);
                if (F) {
                    G.type = "gradienttitle";
                    G.color2 = G.color;
                    G.opacity = 0
                }
                y.path = I;
                v = y.style;
                v.left = H;
                v.top = w;
                v.width = m;
                v.height = l;
                return y
            }

            var b = this, c = this.d, g = this.u(), e = this.h, d =
                e.R.j().pa;
            e = e.s.j();
            var f = d.length, i = f, j, k = this.o.m(), m = k.g, l = k.e;
            k = h.D === 8 ? 1 : 0;
            for (var u = ["tl", "tr", "br", "bl"], n, q, t, v, x, r, o, s, p, z, E, C, A, B; i--;) {
                q = d[i];
                x = q.Xc.a(c);
                r = q.Yc.a(c);
                j = q.Pc.a(c);
                o = q.blur.a(c);
                q = q.color;
                s = -j - o;
                if (!e && o)e = h.Ia.Ib;
                s = this.ka({P:s, O:s, K:s, M:s}, 2, e);
                if (o) {
                    p = (j + o) * 2 + m;
                    z = (j + o) * 2 + l;
                    E = o * 2 / p;
                    C = o * 2 / z;
                    if (o - j > m / 2 || o - j > l / 2)for (j = 4; j--;) {
                        n = u[j];
                        A = n.charAt(0) === "b";
                        B = n.charAt(1) === "r";
                        n = a(i, n, x, r, q, o, s);
                        t = n.fill;
                        t.focusposition = (B ? 1 - E : E) + "," + (A ? 1 - C : C);
                        t.focussize = "0,0";
                        n.style.clip = "rect(" +
                            ((A ? z / 2 : 0) + k) + "px," + (B ? p : p / 2) + "px," + (A ? z : z / 2) + "px," + ((B ? p / 2 : 0) + k) + "px)"
                    } else {
                        n = a(i, "", x, r, q, o, s);
                        t = n.fill;
                        t.focusposition = E + "," + C;
                        t.focussize = 1 - E * 2 + "," + (1 - C * 2)
                    }
                } else {
                    n = a(i, "", x, r, q, o, s);
                    x = q.ha();
                    if (x < 1)n.fill.opacity = x
                }
            }
        }});
        h.Tb = h.A.U({B:6, za:"imgEl", N:function () {
            var a = this.h;
            return this.d.src !== this.$b || a.s.C()
        }, f:function () {
            var a = this.h;
            return a.s.f() || a.G.wb()
        }, S:function () {
            this.Bc();
            var a = this.na("img", "fill", this.u()), b = a.fill, c = this.o.m(), g = c.g;
            c = c.e;
            var e = this.h.H.j(), d = e && e.gb, f = this.d;
            e =
                f.src;
            var i = Math.round;
            a.stroked = false;
            b.type = "frame";
            b.src = e;
            b.position = 0.5 / g + "," + 0.5 / c;
            a.coordsize = g * 2 + "," + c * 2;
            a.coordorigin = "1,1";
            a.path = this.ka(d ? {P:i(d.t.a(f)), O:i(d.r.a(f)), K:i(d.b.a(f)), M:i(d.l.a(f))} : 0, 2);
            a = a.style;
            a.width = g;
            a.height = c;
            this.$b = e
        }, Bc:function () {
            this.d.runtimeStyle.filter = "alpha(opacity=0)"
        }, k:function () {
            h.A.k.call(this);
            this.d.runtimeStyle.filter = ""
        }});
        h.Ka = function () {
            function a(f) {
                function i() {
                    if (!B) {
                        var w, D, F = f.currentStyle.getAttribute(c) === "true";
                        if (!A) {
                            A = 1;
                            f.runtimeStyle.zoom =
                                1;
                            for (var I = f, M = 1; I = I.previousSibling;)if (I.nodeType === 1) {
                                M = 0;
                                break
                            }
                            if (M)f.className += " " + h.Ja + "first-child"
                        }
                        p.Da();
                        if (F && (D = p.m()) && (w = doc.documentElement || doc.body) && (D.y > w.clientHeight || D.x > w.clientWidth || D.y + D.e < 0 || D.x + D.g < 0)) {
                            if (!G) {
                                G = 1;
                                h.Ma.W(i)
                            }
                        } else {
                            B = 1;
                            G = A = 0;
                            h.Ma.Ga(i);
                            z = {G:new h.Lb(f), H:new h.Pb(f), L:new h.Nb(f), s:new h.Ia(f), R:new h.Rb(f), eb:new h.Wb(f)};
                            E = [z.G, z.H, z.L, z.s, z.R, z.eb];
                            w = new h.Ub(f, p, z);
                            D = [new h.Qb(f, p, z, w), new h.Kb(f, p, z, w), new h.Ob(f, p, z, w), new h.Mb(f, p, z, w)];
                            f.tagName ===
                                "IMG" && D.push(new h.Tb(f, p, z, w));
                            w.hc = D;
                            s = [w].concat(D);
                            if (w = f.currentStyle.getAttribute(h.I + "watch-ancestors")) {
                                C = [];
                                w = parseInt(w, 10);
                                D = 0;
                                for (F = f.parentNode; F && (w === "NaN" || D++ < w);) {
                                    C.push(F);
                                    F.attachEvent("onpropertychange", t);
                                    F.attachEvent("onmouseenter", n);
                                    F.attachEvent("onmouseleave", q);
                                    F = F.parentNode
                                }
                            }
                            h.Wa === 8 && h.La.W(k);
                            k(1)
                        }
                        if (!y) {
                            y = 1;
                            f.attachEvent("onmove", j);
                            f.attachEvent("onresize", j);
                            f.attachEvent("onpropertychange", m);
                            f.attachEvent("onmouseenter", n);
                            f.attachEvent("onmouseleave", q);
                            h.ta.W(j);
                            h.F.W(r)
                        }
                        p.Fa()
                    }
                }

                function j() {
                    p && p.zc() && k()
                }

                function k(w) {
                    if (!H)if (B) {
                        var D, F;
                        v();
                        if (w || p.Kc()) {
                            D = 0;
                            for (F = s.length; D < F; D++)s[D].cb()
                        }
                        if (w || p.Nc()) {
                            D = 0;
                            for (F = s.length; D < F; D++)s[D].Db()
                        }
                        x()
                    } else A || i()
                }

                function m() {
                    var w, D, F;
                    w = event;
                    if (!H && !(w && w.propertyName in d))if (B) {
                        v();
                        w = 0;
                        for (D = s.length; w < D; w++) {
                            F = s[w];
                            F.Za || F.cb();
                            F.N() && F.Cb()
                        }
                        x()
                    } else A || i()
                }

                function l() {
                    f.className += g
                }

                function u() {
                    f.className = f.className.replace(e, "")
                }

                function n() {
                    setTimeout(l, 0)
                }

                function q() {
                    setTimeout(u, 0)
                }

                function t() {
                    var w =
                        event.propertyName;
                    if (w === "className" || w === "id")m()
                }

                function v() {
                    p.Da();
                    for (var w = E.length; w--;)E[w].Da()
                }

                function x() {
                    for (var w = E.length; w--;)E[w].Fa();
                    p.Fa()
                }

                function r() {
                    if (y) {
                        if (C)for (var w = 0, D = C.length, F; w < D; w++) {
                            F = C[w];
                            F.detachEvent("onpropertychange", t);
                            F.detachEvent("onmouseenter", n);
                            F.detachEvent("onmouseleave", q)
                        }
                        f.detachEvent("onmove", k);
                        f.detachEvent("onresize", k);
                        f.detachEvent("onpropertychange", m);
                        f.detachEvent("onmouseenter", n);
                        f.detachEvent("onmouseleave", q);
                        h.F.Ga(r);
                        y = 0
                    }
                }

                function o() {
                    if (!H) {
                        var w,
                            D;
                        r();
                        H = 1;
                        if (s) {
                            w = 0;
                            for (D = s.length; w < D; w++)s[w].k()
                        }
                        h.Wa === 8 && h.La.Ga(k);
                        h.ta.Ga(k);
                        s = p = z = E = C = f = null
                    }
                }

                var s, p = new K(f), z, E, C, A, B, y, G, H;
                this.Dc = i;
                this.update = k;
                this.k = o;
                this.vc = f
            }

            var b = {}, c = h.I + "lazy-init", g = " " + h.Ja + "hover", e = new RegExp("\\b" + h.Ja + "hover\\b", "g"), d = {background:1, bgColor:1, display:1};
            a.xc = function (f) {
                var i = h.n.oa(f);
                return b[i] || (b[i] = new a(f))
            };
            a.k = function (f) {
                f = h.n.oa(f);
                var i = b[f];
                if (i) {
                    i.k();
                    delete b[f]
                }
            };
            a.rc = function () {
                var f = [], i;
                if (b) {
                    for (var j in b)if (b.hasOwnProperty(j)) {
                        i =
                            b[j];
                        f.push(i.vc);
                        i.k()
                    }
                    b = {}
                }
                return f
            };
            return a
        }();
        h.attach = function (a) {
            h.D < 9 && h.Ka.xc(a).Dc()
        };
        h.detach = function (a) {
            h.Ka.k(a)
        }
    }
    ;
})();