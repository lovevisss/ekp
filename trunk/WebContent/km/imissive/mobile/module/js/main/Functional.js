define(["dojo/_base/declare","mui/i18n/i18n!km-imissive:kmImissive.tree"], function(declare,Msg) {
  return declare("", null, {
    datas: [
      [
        {
          icon: "muis-send",
          text: Msg["kmImissive.tree.Send"], // 发文
          href: "/km/imissive/mobile/imissive_send/index.jsp",
          countUrl: "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.docStatus=20&rowsize=1",
          countPath: "page.totalSize"
        },
        {
          icon: "muis-accept",
          text: Msg["kmImissive.tree.Receive"], // 收文
          href: "/km/imissive/mobile/imissive_receive/index.jsp",
          countUrl: "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.docStatus=20&rowsize=1",
          countPath: "page.totalSize"
        },
        {
          icon: "muis-report",
          text: Msg["kmImissive.tree.Sign"], // 签报
          href: "/km/imissive/mobile/imissive_sign/index.jsp",
          countUrl: "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&q.docStatus=20&rowsize=1",
          countPath: "page.totalSize"
        },
        {
          icon: "muis-exchange-stock",
          text: Msg["kmImissive.tree.Exchange"], // 交换库
          href: "/km/imissive/mobile/exchange_library/index.jsp"       
        }
      ]
    ]
  })
})
