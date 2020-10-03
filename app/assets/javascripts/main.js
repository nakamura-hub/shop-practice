$(()=> {
  /**
   * 星レビュー機能
   */
  const stars = $(".ratings").find('#star > i');
  const ratingValue = $("#rating-value");
  const ratingValueDisplay = $(".rating-value-display");

  let index;
  
  for (let i = 0; i < stars.length; i++) {
  
    $(stars[i]).on('click', () => {
      
      ratingValue.val = i + 1;
      ratingValueDisplay.text(ratingValue.val);
      
      $(ratingValue).val(ratingValue.val);
  
      index = i;
      
      $(".star-btn").prop('disabled', false);
    })
    .on('mouseover', () => {
      for (let j = 0; j < stars.length; j++) {
        $(stars[j]).removeClass("fas");
        $(stars[j]).addClass("far");
      }
  
      for (let j = 0; j <= i; j++) {
        $(stars[j]).removeClass("far");
        $(stars[j]).addClass("fas");
      }
    })
    .on('mouseout', () => {
      for (let j = 0; j < stars.length; j++) {
        $(stars[j]).removeClass("fas");
        $(stars[j]).addClass("far");
      }
  
      for (let j = 0; j <= index; j++) {
        $(stars[j]).removeClass("far");
        $(stars[j]).addClass("fas");
      }
    });
  }


  /**
   * スティッキーヘッダー
   */
  const headerSticky = () => {
    const $window = $(window),
      $header = $('.page-header'),
      headerOffsetTop = $header.offset().top;
    
    $window.on('scroll', () => {
      if ($window.scrollTop() > headerOffsetTop) {
        $header.addClass('sticky');
        $header.addClass('page-header_shadow');
      } else {
        $header.removeClass('sticky');
        $header.removeClass('page-header_shadow');
      }
    });
  };
  
  headerSticky();
  
  const updateButton = () => {
    if ($(window).scrollTop() >= 654) {
      $('.back-to-top').fadeIn();
    } else {
      $('.back-to-top').fadeOut();
    }
  };
  
  // スクロールされる度にupdateButtonを実行
  $(window).on('scroll', updateButton);
  
  // ページの途中でリロード（再読み込み）された場合でも、
  // ボタンが表示されるようにする
  updateButton();
  

  /**
   * ボタンをクリックしたらページトップにスクロールする
   */
  $('.back-to-top').on('click', (event) => {
    // ボタンのhrefに遷移しない
    event.preventDefault();
  
    // 600ミリ秒かけてトップに戻る
    $('html, body').animate({ scrollTop: 0 }, 600);
  });
  
  // 右クリックでモーダル表示
  $("#product_main").on('contextmenu', (e) => {
    $('#Modal').modal("show");
  });


/**
  *
  * ナビバーメニュー
  */
$('#menu-btn').on('click', () => {
  $('#menu-btn').toggleClass('is-open');
});


/**
 * 
 * スタッフID生成
 */
 $('#submit').on('click', () => {
   let $staff_id = $('#staff_id');
  console.log($staff_id);
 
  let seed1 = [];
  let seed2 = [];
  let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  const SORT_LEN = 1000000;

  for (let i = 111; i < 999; i++) {
    seed1.push(i);
  }
  seed2 = seed1;

  for (let i = 0; i < SORT_LEN; i++) {
    let before = Math.floor(Math.random() * seed1.length);
    let after = Math.floor(Math.random() * seed1.length);
    let tmp = seed1[before];
    seed1[before] = seed1[after];
    seed1[after] = tmp;
  }

  for (let i = 0; i < SORT_LEN; i++) {
    let before = Math.floor(Math.random() * seed2.length);
    let after = Math.floor(Math.random() * seed2.length);
    let tmp = seed2[before];
    seed2[before] = seed2[after];
    seed2[after] = tmp;
  }

    let strSeedRand = Math.floor(Math.random() * str.length);
    let seed1Rand = Math.floor(Math.random() * seed1.length);
    let seed2Rand = Math.floor(Math.random() * seed2.length);
    $staff_id.val(str.charAt(strSeedRand) + seed1[seed1Rand] + seed2[seed2Rand]);
 });
 
});
