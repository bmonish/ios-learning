//
//  UserListViewModel.swift
//  MVVMBindings
//
//  Created by monish-pt4649 on 20/01/22.
//

struct UserListViewModel {
    var users: Observable<[UserTableViewCellViewModel]> = Observable([])
}
