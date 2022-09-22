
RSpec.describe Honeysearch do
  it "has a version number" do
    expect(Honeysearch::VERSION).not_to be nil
  end

  let(:res1) { Honeysearch::Search.new('aqours') }
  let(:res2) { Honeysearch::Search.new('aqours', 1) }
  let(:res3) { Honeysearch::Search.new('ff14') }

  it "downloads a result" do
    res = res1.result
    expect(Honeysearch::Parser.new(res).results.length).to eq 30
  end

  it "downloads a result page 2" do
    res = res2.result
    expect(Honeysearch::Parser.new(res).results.length).to eq 30
  end
  
  it "downloads a result and shows more" do
    expect(res1.more?).to eq true
  end

  it "downloads a result and shows number" do
    expect(res1.total_number).to eq 92
  end

  it "downloads a result and shows number 2" do
    expect(res3.total_number).to eq 21
  end

  it "downloads a result and shows more" do
    expect(res3.more?).to eq false
  end

  it 'parses a result' do
    RESULT=<<~RESULT
          <html>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
      <head>
        <title>カラオケパセラ 検索・ランキング・新譜情報｜MUEカラオケ</title>
        <meta name="keywords" content="パセラ,カラオケ,ランキング,人気,新曲,新譜,検索,洋楽,韓国,中国,外国曲">
        <meta name="description" content="カラオケパセラのオリジナルカラオケシステム「MUEカラシステム」は曲数世界最強！ だからあなたの歌いたい曲がきっと見つかる！人気カラオケランキング、楽曲検索、新曲情報サイト。">
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/bgswitcher.js"></script>
        <link rel="stylesheet" type="text/css" href="css/pasela.css"/ media="screen and (min-width:769px)" >
        <link rel="stylesheet" type="text/css" href="css/pasela_sp.css"/ media="screen and (max-width:768px)" >
      <script type="text/javascript">
      var now_page = 0;
      </script>

        <script type="text/javascript">
      history.replaceState(null, document.getElementsByTagName('title')[0].innerHTML, null);
      window.addEventListener('popstate', function() {
              if($("#loading").length != 0){
                      $("#loading").remove();
              }
      }, false);

        $(window).unload(function(){
              if($("#loading").length != 0){
                      $("#loading").remove();
              }
        });

        var i_commit = 0;

        function getScrollBottom() {
              var body = window.document.body;
              var html = window.document.documentElement;
              var scrollTop = body.scrollTop || html.scrollTop;
              var mh = html.scrollHeight;
              if (html.scrollHeight < html.clientHeight) {
                      mh = html.clientHeight;
              }
              var y = mh - scrollTop;
              return y;
        }

        $(document).ready(function(){
            //BGSWITCHER設定
            $('#bgswitcher').bgSwitcher({
              images: ['images/top_01.jpg','images/top_02.jpg','images/top_03.jpg','images/top_04.jpg','images/top_05.jpg'],
              interval: 5000
            });
        });
        $(window).ready(function(){
        // humボタンのクリック
            $('#hum').on('click',function(){
              $('#navi').css({transform:'translate(0,110vw)'});
            });
        // navi_closeボタンのクリック
            $('#navi_close').on('click',function(){
              $('#navi').css({transform:'translate(0,-110vw)'});
            });
        //topbackボタンの初期非表示
            var topback = $('#topback');
            topback.hide();
        //スクロールでtopbackボタンの表示
            $(window).scroll(function(){
              
              if (getScrollBottom() < 700){
                  topback.fadeIn();
              }else{
                  topback.fadeOut();
              }
            });
        // スクロールの速度を落とす
            $('a[href^="#"]').click(function() {
            // スクロールの速度を選択
            var speed = 200;
            // アンカーの値取得する
            var href= $(this).attr("href");
            // 移動先を取得する
            var target = $(href == "#" || href == "" ? 'html' : href);
            // 移動先を数値で取得する
            var position = target.offset().top;
            // スムーススクロールの設定
            $('body,html').animate({scrollTop:position}, speed, 'swing');
            return false;
            });
        });
        //レスポンシブルの切り替えでリロード
        var timer = 0;
        var currentWidth = window.innerWidth;
        $(window).resize(function(){
            if (currentWidth == window.innerWidth) {
                return;
            }
            if (timer > 0) {
                clearTimeout(timer);
            }
            timer = setTimeout(function () {
                location.reload();
            }, 200);
          });

          function gotoPage(page) {
            if($("#loading").length == 0){
                        var action = document.frm.action;
                  action = action + "?p=" + page;
                  document.frm.action = action;
                  dispLoading();
                  setTimeout(function() {document.frm.submit();}, 500);
            }
          }

          function dispLoading(){
              if($("#loading").length == 0){
                      $("body").append("<div id='loading'><div class='loadingMsg'>ページ切り替え中</div></div>");
              }
          }

          function onSelectRows() {
              if($("#loading").length == 0){
                  var action = document.frm.action;
                  action = action + "?p=" + now_page;
                  var sel_rows = document.getElementById("id_sel_rows").value;
                  document.frm.sel_rows.value = sel_rows;
                  document.frm.action = action;
                  dispLoading();
                  setTimeout(function() {document.frm.submit();}, 500);
              }
          }

        </script>

      <style>
      @media screen and (max-width: 768px) {
              .search_list li a{
                      margin: 0;
                      display: block;
                      text-decoration: none;
                      color: #000;
              }
      }

      #loading {
              display: table;
              width: 100%;
              height: 100%;
              position: fixed;
              top: 0;
              left: 0;
              background-color: #fff;
              opacity: 0.8;
              z-index: 2000;
      }

      #loading .loadingMsg {
              display: table-cell;
              text-align: center;
              vertical-align: middle;
              padding-top: 140px;
              background: url("images/loading.gif") center center no-repeat;
      }

      .select_box {
              font-size: 16px;
              margin-bottom: 16px;
      }

      @media screen and (max-width: 768px) {
              .select_box {
                      width: 80% !important;
                      margin-left: 5%;
                      margin-bottom: 5%;
                      padding: 2vw;
                      font-size: 1.4em !important;
              }
      }

      </style>

      </head>
      <body>
      <div id="waku">
        <div id="header">
              <a href="index.php"><img src="images/logo_small_red.png"></a>
      <img src="images/powerdby_black.png">
      <form name="frm_ser" method="post" action="search_result.php">
      <!--
      <input type="text" name="headersearch_box" id="headersearch_box" class="sp_none" value="" />
      <input type="button" name="headersearch_btn" id="headersearch_btn" class="sp_none"  value="検索" onclick="javascript:document.frm_ser.submit();" />
      -->
      </form>   </div><!-- /header -->
        <div id="navi">
            <ul>
              <li><a href="index.php">ホーム</a></li>
              <li><a href="search.php">カラオケサーチ</a></li>
              <li><a href="ranking.php">カラオケランキング</a></li>
              <li><a href="newsong.php">新譜リスト</a></li>
            </ul>
            <div id="navi_close" class="pc_none">×</div>
        </div><!-- /navi -->
        <div id="search">
            <div class="top_h1">KARAOKE</div>
            <div class="top_h2">SEARCH</div>
            <div class="search_result_h"><select id="id_sel_rows" name="sel_rows" class="select_box" onChange="javascript:onSelectRows();"><option value="10">10行表示</option><option value="30" selected>30行表示</option><option value="50">50行表示</option><option value="100">100行表示</option></select><br/>
              検索結果：92曲 (1～30曲を表示中)</div>
            <div class="searchtop_btn sp_none"><a href="search.php?rows=30&sk=aqours,,,,,0,">検索TOPへ</a></div>
            <div class="sp_none">
            <ul id="search_name" class="search_list">
              <li>歌手名</li>
              <li>曲名</li>
              <li>曲番号</li>
              <li>歌い出し</li>
              <li>タイアップ</li>
              <li>ジャンル</li>
            </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>i-n-g, I TRY!!</li>
                  <li>4570B6</li>
                  <li>まるで夢のようなって</li>
                  <li>ラブライブ!サンシャイン!!The School Idol Movie Over the...<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>青空Jumping Heart</li>
                  <li>3210B2</li>
                  <li>見たことない夢の軌道 追いかけ</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>青空Jumping Heart</li>
                  <li>3745B24</li>
                  <li>見たことない夢の軌道 追いかけ</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>青空Jumping Heart【DAMﾗｲﾌﾞ】</li>
                  <li>3962B37</li>
                  <li>見たことない夢の軌道 追いかけ</li>
                  <li>Animelo Summer Live<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>青空Jumping Heart [歌ってみた利用OK]【歌ってみた利用OK】</li>
                  <li>4415B27</li>
                  <li>見たことない夢の軌道 追いかけ</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Aqours Pirates Desire</li>
                  <li>4419A5</li>
                  <li>暗い… 夜の海には魔が宿るのさ</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Aqours☆HEROES</li>
                  <li>3541B47</li>
                  <li>Yaa-Yaa!! やあやあやあ 準備は</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Aqoursメドレー</li>
                  <li>3870B29</li>
                  <li>JOY</li>
                  <li></li>
                  <li>ポップス</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Wake up, Challenger!!</li>
                  <li>4288B6</li>
                  <li>なんともなんない! じゃなくて</li>
                  <li>ラブライブ! スクールアイドルフェスティバル ALL STARS<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>WATER BLUE NEW WORLD</li>
                  <li>3945B42</li>
                  <li>イマはイマで昨日と違うよ 明日</li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>WATER BLUE NEW WORLD</li>
                  <li>4100B23</li>
                  <li>イマはイマで昨日と違うよ 明日</li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>想いよひとつになれ</li>
                  <li>3726A31</li>
                  <li>想いよひとつになれ 想いが</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>想いよひとつになれ</li>
                  <li>3966A5</li>
                  <li>想いよひとつになれ 想いが</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>KA-GA-YA-KI-RA-RI-RA feat.初音ミク【VOCALOID】</li>
                  <li>4682A2</li>
                  <li>ねえ、聴いて? 声と音でセカイを</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>キセキヒカル</li>
                  <li>4439B29</li>
                  <li></li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>君のこころは輝いてるかい?</li>
                  <li>3523B33</li>
                  <li>今・・・ みらい、変えてみたく</li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>君のこころは輝いてるかい?</li>
                  <li>3711B16</li>
                  <li>今・・・ みらい、変えてみたく</li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>君の瞳を巡る冒険</li>
                  <li>3908B40</li>
                  <li>謎は謎はいつも 目の前で違う</li>
                  <li>ラブライブ!サンシャイン!!(第2期)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>決めたよHand in Hand</li>
                  <li>3673A6</li>
                  <li>Hand in Hand,wow wo!・・・ なにを</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>KU-RU-KU-RU Cruller!</li>
                  <li>4551A2</li>
                  <li>Happy dance happy dance KU-RU</li>
                  <li>モンスターストライク×ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>恋になりたいAQUARIUM</li>
                  <li>3626B18</li>
                  <li>空色カーテン Open! 海色ゲート</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>恋になりたいAQUARIUM</li>
                  <li>3711B17</li>
                  <li>空色カーテン Open! 海色ゲート</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>心の羽よ君へ飛んでけ!</li>
                  <li>4496A17</li>
                  <li>ああ、変わってゆく 真っ青だった</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>KOKORO Magic 'A to Z'</li>
                  <li>4288B7</li>
                  <li>なんでもないような毎日(でも?)</li>
                  <li>ラブライブ! スクールアイドルフェスティバル ALL STARS<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Thank you,FRIENDS!!</li>
                  <li>4049A42</li>
                  <li>そう、いまだから そういま僕ら</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>サンシャインぴっかぴか音頭</li>
                  <li>3685A44</li>
                  <li>あっちから こっちから</li>
                  <li>ラブライブ!サンシャイン!!(TV版)<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>JIMO-AI Dash!</li>
                  <li>4427B24</li>
                  <li>My love,my place! ココだよキミ</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>Jump up HIGH!!</li>
                  <li>4223A1</li>
                  <li>Jump up! 空高く舞う鳥へ</li>
                  <li>ラブライブ!サンシャイン!!<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>少女以上の恋がしたい</li>
                  <li>3793B1</li>
                  <li>知りたい 触れたい 今までどおり</li>
                  <li>ラブライブ! スクールアイドルフェスティバル<番組名></li>
                  <li>アニメ</li>
              </ul>
                    <ul class="search_list">
                  <li>Aqours</li>
                  <li>ジングルベルがとまらない</li>
                  <li>3733B17</li>
                  <li>えがおが見たくて 今年も迷うの</li>
                  <li>ラブライブ! スクールアイドルフェスティバル<番組名></li>
                  <li>アニメ</li>
              </ul>
                  </div>

            <div id="search_result" class="pc_none">
                    <ul class="search_list">
                  <li><a href="database.php?id=4570B6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4570B6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">i-n-g, I TRY!!</a></li>
                  <li>4570B6</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3210B2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3210B2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">青空Jumping Heart</a></li>
                  <li>3210B2</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3745B24&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3745B24&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">青空Jumping Heart</a></li>
                  <li>3745B24</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3962B37&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3962B37&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">青空Jumping Heart【DAMﾗｲﾌﾞ】</a></li>
                  <li>3962B37</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4415B27&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4415B27&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">青空Jumping Heart [歌ってみた利用OK]【歌ってみた利用OK】</a></li>
                  <li>4415B27</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4419A5&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4419A5&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours Pirates Desire</a></li>
                  <li>4419A5</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3541B47&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3541B47&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours☆HEROES</a></li>
                  <li>3541B47</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3870B29&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3870B29&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqoursメドレー</a></li>
                  <li>3870B29</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4288B6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4288B6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Wake up, Challenger!!</a></li>
                  <li>4288B6</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3945B42&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3945B42&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">WATER BLUE NEW WORLD</a></li>
                  <li>3945B42</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4100B23&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4100B23&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">WATER BLUE NEW WORLD</a></li>
                  <li>4100B23</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3726A31&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3726A31&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">想いよひとつになれ</a></li>
                  <li>3726A31</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3966A5&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3966A5&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">想いよひとつになれ</a></li>
                  <li>3966A5</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4682A2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4682A2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">KA-GA-YA-KI-RA-RI-RA feat.初音ミク【VOCALOID】</a></li>
                  <li>4682A2</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4439B29&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4439B29&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">キセキヒカル</a></li>
                  <li>4439B29</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3523B33&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3523B33&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">君のこころは輝いてるかい?</a></li>
                  <li>3523B33</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3711B16&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3711B16&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">君のこころは輝いてるかい?</a></li>
                  <li>3711B16</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3908B40&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3908B40&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">君の瞳を巡る冒険</a></li>
                  <li>3908B40</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3673A6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3673A6&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">決めたよHand in Hand</a></li>
                  <li>3673A6</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4551A2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4551A2&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">KU-RU-KU-RU Cruller!</a></li>
                  <li>4551A2</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3626B18&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3626B18&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">恋になりたいAQUARIUM</a></li>
                  <li>3626B18</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3711B17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3711B17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">恋になりたいAQUARIUM</a></li>
                  <li>3711B17</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4496A17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4496A17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">心の羽よ君へ飛んでけ!</a></li>
                  <li>4496A17</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4288B7&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4288B7&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">KOKORO Magic 'A to Z'</a></li>
                  <li>4288B7</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4049A42&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4049A42&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Thank you,FRIENDS!!</a></li>
                  <li>4049A42</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3685A44&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3685A44&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">サンシャインぴっかぴか音頭</a></li>
                  <li>3685A44</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4427B24&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4427B24&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">JIMO-AI Dash!</a></li>
                  <li>4427B24</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=4223A1&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=4223A1&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Jump up HIGH!!</a></li>
                  <li>4223A1</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3793B1&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3793B1&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">少女以上の恋がしたい</a></li>
                  <li>3793B1</li>
              </ul>
                    <ul class="search_list">
                  <li><a href="database.php?id=3733B17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">Aqours</a></li>
                  <li><a href="database.php?id=3733B17&rp=search_result&sk=aqours,,,,,0,&p=0&sel_rows=30">ジングルベルがとまらない</a></li>
                  <li>3733B17</li>
              </ul>
                  </div>
            <form name=frm method="post" action="search_result.php">
            <div id="prevnext_box">
              <span class="prevnext"></span>
              <span><a href="search.php?rows=30&sk=aqours,,,,,0,">検索TOPへ</a></span>
                        <span class="prevnext"><a href="javascript:gotoPage(1);">次の30曲</a></span>
                    </div>
            <input type="hidden" name="sel_rows" value="30">      <input type="hidden" name="s_title" value="">
            <input type="hidden" name="s_singer" value="">
            <input type="hidden" name="s_singer_id" value="">
            <input type="hidden" name="s_intro" value="">
            <input type="hidden" name="s_tieup" value="">
            <input type="hidden" name="sel_search_genre" value="0">
            <input type="hidden" name="topsearch_box" value="aqours">
            </form>
        </div><!-- /search -->
        <div id="foot_navi" class="sp_none">
            <a class="foot_navi_list" href="index.php">ホーム</a>|
            <a class="foot_navi_list" href="search.php">カラオケサーチ</a>|
            <a class="foot_navi_list" href="ranking.php">カラオケランキング</a>|
            <a class="foot_navi_list" href="newsong.php">新譜リスト</a>
        </div><!-- /foot_navi -->
        <ul id="sp_foot_navi" class="pc_none">
            <li class="sp_foot_navi_list"><a href="index.php"><img src="images/spbtn_home.png"><span>ホーム</span></a></li>
            <li class="sp_foot_navi_list"><a href="search.php"><img src="images/spbtn_search.png"><span>カラオケサーチ</span></a></li>
            <li class="sp_foot_navi_list"><a href="ranking.php"><img src="images/spbtn_ranking.png"><span>カラオケランキング</span></a></li>
            <li class="sp_foot_navi_list"><a href="newsong.php"><img src="images/spbtn_new.png"><span>新譜リスト</span></a></li>
        </ul><!-- /sp_foot_navi -->
        <div id="footer" class="center">
            <div class="site"><a href="http://pasela.co.jp" target="_blank">カラオケパセラ　オフィシャルサイト</a></div>
            <div class="copy">Copyright 2018 Pasela Resorts. Powered by MUE Karaoke System.</div>
      </div><!-- /footer -->


      <!-- Global site tag (gtag.js) - Google Analytics -->
      <script async src="https://www.googletagmanager.com/gtag/js?id=UA-129536340-1"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-129536340-1');
      </script>
        <div id="topback">
            <a href="#waku"><img src="images/topback.png"></a>
        </div>
      </div><!-- /waku -->
      <div id="hum" class="pc_none"><img src="images/menu.png"></div>
      </body>
      </html>
    RESULT

    expect(Honeysearch::Parser.new(RESULT).results.length).to eq 30
  end
end
