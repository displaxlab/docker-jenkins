function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton, 3000);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton, 4000);
}

Controller.prototype.CredentialsPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var page = gui.pageWidgetByObjectName("CredentialsPage");
    page.loginWidget.EmailLineEdit.setText("dpxskinlab@gmail.com");
    page.loginWidget.PasswordLineEdit.setText("Dpxis1357!");
    gui.clickButton(buttons.NextButton, 4000);
}

Controller.prototype.ObligationsPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);
    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.DynamicTelemetryPluginFormCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var widget = gui.currentPageWidget();
    widget.TelemetryPluginForm.statisticGroupBox.disableStatisticRadioButton.checked = true;
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("C:\\Qt");
    gui.clickButton(buttons.NextButton, 2000);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var widget = gui.currentPageWidget();

    widget.deselectAll();
    widget.selectComponent("qt.qt5.5142.win32_msvc2017");
    widget.selectComponent("qt.qt5.5142.qtwebglplugin");
    widget.selectComponent("qt.qt5.5142.qtwebengine");
    widget.selectComponent("qt.qt5.5142.qtvirtualkeyboard");
    widget.selectComponent("qt.qt5.5142.qtscript");
    widget.selectComponent("qt.qt5.5142.qtremoteobjects");
    widget.selectComponent("qt.qt5.5142.qtpurchasing");
    widget.selectComponent("qt.qt5.5142.qtcharts");
    widget.selectComponent("qt.qt5.5142.qtnetworkauth");
    widget.selectComponent("qt.qt5.5142.qtdatavis3d");
    widget.selectComponent("qt.tools.ifw.32");
    widget.selectComponent("qt.tools.openssl.win_x86");
    gui.clickButton(buttons.NextButton, 5000);
}

Controller.prototype.PerformInstallationPageCallback = function() {    
    var widget = gui.currentPageWidget();
    gui.clickButton(buttons.CommitButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
13