//
//  Logo.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct Logo: View {
    var logo: Image {
        Image("logo")
            .clipShape(RoundedRectangle(cornerRadius: 100, style: .continuous)) as! Image
    }
    
    var body: some View {
        Image("logo")

    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
