class Homes extends React.Component {
  constructor(props){
    super(props);
    this.visitor_uuid = this.props.visitor_uuid;
    this.channel_config = {
      channel: 'HomesChannel',
      visitor_uuid: this.props.visitor_uuid
    }
  }

  componentWillMount(){
    if (this.visitor_uuid) {
      this.generate_channel();
    }
  }

  generate_channel(){
    visitor_uuid = this.visitor_uuid;
    App.Home = App.cable.subscriptions.create(this.channel_config, {
      connected: function(data){
        this.crawler({visitor_uuid: visitor_uuid});
      },
      received: function(result){
        this.append_crawler(result.homes)
      },
      crawler: function(params = {}) {
        return this.perform("airbnb_crawler", params);
      },
      append_crawler: function(record) {
        $('.homes').empty();
        $('.homes').append(record);
        slickJs();
      }
    });
  }
  render(){
    return (
      <main className="u-main cf" role="main">
        <div className="u-list-wrap cf homes">
          <div style={{ margin: 'auto' }}> 
            <div className="lds-ellipsis"><div></div><div></div><div></div><div></div></div>
          </div>
        </div>
        <nav className="u-pager cf">
          <a className="u-page u-back" href="#">
            <i className="material-icons">keyboard_arrow_left</i>
            back
          </a>
          <a className="u-page u-next" href="#">
            next
            <i className="material-icons">keyboard_arrow_right</i>
          </a>
        </nav>
      </main>
    )
  }
}