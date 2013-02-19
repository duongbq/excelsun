<!-- Main Section -->

<section class="grid_6 first top">

    <!--                        <div class="columns">
                                <div class="grid_6 first">
                                    <div class="message info closeable">
                                        <h3>Quick Help - Dashboard</h3>
                                        <p>
                                            You can do the following on this dashboard:
                                        </p>
                                        <ol>
                                            <li>Drag and drop widgets to the left or right column by using the header.</li>
                                            <li>To expand/collapse the widgets, hover your mouse on the header and an expand/collapse button will appear.</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>-->

    <div class="columns">

        <div class="column grid_3 first">

            <div class="widget collapsible">
                <header>
                    <h2>Transaction Statistics</h2></header>
                <section>
                    <table class="no-style full">

                        <tbody>

                        <tr>

                            <td>PayPal Transactions</td>

                            <td class="ar"><a href="#">30</a></td>

                            <td class="ar">1,498.50 $</td>

                        </tr>

                        <tr>

                            <td>Total Minutes</td>

                            <td class="ar"><a href="#">30</a></td>

                            <td class="ar">900 minutes</td>

                        </tr>

                        </tbody>

                    </table>
                </section>
            </div>

            <div class="widget collapsible">
                <header><h2>Client Statistics: <a href="#">100</a></h2></header>
                <section>
                    <table class="no-style full">

                        <tbody>

                        <tr>

                            <td>Active</td>

                            <td style="width:70%">
                                <div id="progress1" class="progress progress-green"><span style="width: 51%;"><b>51%</b></span>
                                </div>
                            </td>

                            <td style="width:40px" class="ar">51/100</td>

                        </tr>

                        <tr>

                            <td>Pending</td>

                            <td>
                                <div class="progress progress-blue"><span style="width: 3%;"><b>3%</b></span></div>
                            </td>

                            <td class="ar">3/10</td>

                        </tr>

                        </tbody>

                    </table>
                </section>
            </div>

        </div>

        <div class="column grid_3 last">

            <div class="widget collapsible">
                <header><h2>Sales Statistics</h2></header>

                <section>
                    <table class="no-style full">

                        <tbody>

                        <tr>

                            <td>Signups This Month</td>

                            <td class="ar"><a href="#">30</a></td>

                            <td class="ar"></td>

                        </tr>

                        <tr>

                            <td>Sales This Month</td>

                            <td class="ar"><a href="#">25</a></td>

                            <td class="ar">1,248.75 $</td>

                        </tr>

                        <tr>

                            <td>Signups This Year</td>

                            <td class="ar"><a href="#">30</a></td>

                            <td class="ar"></td>

                        </tr>

                        <tr>

                            <td>Sales This Year</td>

                            <td class="ar"><a href="#">25</a></td>

                            <td class="ar">1,248.75 $</td>

                        </tr>

                        </tbody>

                    </table>

                </section>
            </div>

            <div class="widget collapsible">
                <header>
                    <h2>Partner</h2></header>
                <section>
                    <table class="no-style full">

                        <tbody>

                        <tr>

                            <td>Ambassador</td>

                            <td class="ar"><a href="#">130</a></td>

                        </tr>

                        <tr>

                            <td>Coach</td>

                            <td class="ar"><a href="#">22</a></td>

                        </tr>

                        <tr>

                            <td>Employee</td>

                            <td class="ar"><a href="#">10</a></td>

                        </tr>

                        <tr>

                            <td>Default</td>

                            <td class="ar"><a href="#">1</a></td>

                        </tr>

                        </tbody>

                    </table>

                </section>
            </div>
        </div>

    </div>

    <div class="clear">&nbsp;</div>

</section>

<!-- Main Section End -->

<!-- Sidebar -->

<aside class="grid_2 top">

    <div class="accordion">

        <header class="current"><h2>Objective</h2></header>
        <section style="display:block">
            <dl>
                <dt>Objective :</dt>
                <dd><input type="text" value="1000" style="width:198px"/></dd>
                <dt>Actual Users : 100/1000</dt>
                <dd>
                    <div class="progress progress-green"><span style="width: 10%;"><b>10%</b></span></div>
                </dd>
            </dl>
        </section>

        <header><h2>Documentation</h2></header>
        <section>... content here ...</section>

    </div>

</aside>

<!-- Sidebar End -->

<script>
    $(function () {
        var d1 = [];
        for (var i = 0; i < 14; i += 0.5)
            d1.push([i, Math.sin(i)]);

        var d2 = [
            [0, 3],
            [4, 8],
            [8, 5],
            [9, 13]
        ];

        var d3 = [];
        for (var i = 0; i < 14; i += 0.5)
            d3.push([i, Math.cos(i)]);

        var d4 = [];
        for (var i = 0; i < 14; i += 0.1)
            d4.push([i, Math.sqrt(i * 10)]);

        var d5 = [];
        for (var i = 0; i < 14; i += 0.5)
            d5.push([i, Math.sqrt(i)]);

        var d6 = [];
        for (var i = 0; i < 14; i += 0.5 + Math.random())
            d6.push([i, Math.sqrt(2 * i + Math.sin(i) + 5)]);

        $.plot($("#placeholder"), [
            {
                data:d1,
                lines:{ show:true, fill:true }
            },
            {
                data:d2,
                bars:{ show:true }
            },
            {
                data:d3,
                points:{ show:true }
            },
            {
                data:d4,
                lines:{ show:true }
            },
            {
                data:d5,
                lines:{ show:true },
                points:{ show:true }
            },
            {
                data:d6,
                lines:{ show:true, steps:true }
            }
        ]);
    });
</script>