React = require 'react'

module.exports = React.createClass
  displayName: 'Team'

  render: ->
    <div className="secondary-page">
    <h2 className="team-page-header">Our WildCam Team</h2>
    <div className="team-list">
      <div className="team-member">
        <img src="assets/about/team/paola.png" />
        <div className="team-member-name">Paola Bouley</div>
        <div className="team-member-title">Director & Co-founder</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/rui.png" />
        <div className="team-member-name">Rui Branco</div>
        <div className="team-member-title">Wildlife Veterinarian & Co-founder</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/celina.png" />
        <div className="team-member-name">Celina Dias</div>
        <div className="team-member-title">Lion Researcher</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/domingas.png" />
        <div className="team-member-name">Domingas Alexis</div>
        <div className="team-member-title">Assistant Lion Researcher</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/tonga.png" />
        <div className="team-member-name">Tonga Torcida</div>
        <div className="team-member-title">Assistant Researcher (Seasonal)</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/fernandinho.png" />
        <div className="team-member-name">Fernandinho Pedro</div>
        <div className="team-member-title">Assisstant Researcher (Seasonal)</div>
      </div>
      <div className="team-member">
        <img src="assets/about/team/isaquel_nginga.png" />
        <div className="team-member-name">Isaquel Nginga</div>
        <div className="team-member-title">Lion Project Intern</div>
      </div>

    </div>
    </div>
